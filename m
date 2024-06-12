Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3316F0E4
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193038; cv=none; b=meRQstrRHXAZdjfMVjumB+pjquLy/sudb+owoilGx3x5JvqbTSUsdhgGcCMv4trpiCapSemeAYmJn34S8DJALSL2gjG4JoDongBvz2H30Twlgqnp6Yzc6XUwCn1EoDOdJ3K9yfdUHqGJQ3w4jlHbsdnh71cvOijFkkDNgfKRjCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193038; c=relaxed/simple;
	bh=3amdpxRWX0Kni3EXwejxO+V/NdKvhf83nCBfPl+v9fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhkeuIRNLjXM0t644ePCvY6nbzZp1hRuif8dztlWkdha/YOucmipwceRb7CAmVN9/kXigAkZDyVFiNUVRTxX/qagH82T0G1omxvtaROdesg4JgMBoQLo0dWcXgNWTm4p0MxVvyWtJrvFcO1Du5STDJ1DTC8PLuHv/jBYLuQWRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me; spf=pass smtp.mailfrom=dwim.me; dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b=SA2zD6U6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DgI5Iz5o; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwim.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b="SA2zD6U6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DgI5Iz5o"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id E9AA713801CB;
	Wed, 12 Jun 2024 07:50:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 12 Jun 2024 07:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwim.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1718193034;
	 x=1718279434; bh=0LxF2KXZ1dGxll4lzK5gyOWGwiXMS1HHv+YyQsnAGWo=; b=
	SA2zD6U6xxbWhtfYQU8eIhFitjl74eVzOCNeSniNcby6p27sr7ET766fFXbk0zuV
	gDjHXTO3t/qSWeMmYk73khq1p4uSLDzkjMge1bvoHD3hgzJpnpbf7v1OYkZwgonf
	nYsiH3CrmpwNZaXPoPsi38EGjf0l2PpZYBELzXxvzzztqo0619MvDq5X0cVo3T+f
	Xx9FQITIs1EDaejxD9WnAVQHzbbZw9WAs+3B0dYpptEwnpCV/v0OBSX3h8H+pbtN
	DutMkReGS5KopQwou5YxPHiBuRoi3zLkXcb5Y9/uphbJXGOr7DIBIjbssKN1uOMC
	Kt+BNCcBtlGK/BB6mMnNrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718193034; x=
	1718279434; bh=0LxF2KXZ1dGxll4lzK5gyOWGwiXMS1HHv+YyQsnAGWo=; b=D
	gI5Iz5oV0ru/fh9bhkdHy/XpdW3h2nvUdDCY+vq4Ln2NcX283JPoUuItWiwMG6U5
	1Xh7TBOmj643A323sasDHn1JP2Q2zKtiOGpiUkqFgFPclqOsTHKKLBPiL712PAMH
	p9/Ul9LV5mopQqwmrfzRdNZbQxFEHr1KF5iEHIt/hQN6MzA+8gs5iYr0g2+W27Bf
	NtUVlipZxoyavXsYuSctFscKn68DXzxBacxy7G7npbNz0S4eCxWBAZnTHibT++J2
	Pc6a/HgYlHbwDrHurci7tkvzRSVXnwKBdjSPMoBv/K7iGqepZfnfs1dDAfIhhXAH
	Tycjjxv7hBCuNpamiNKtQ==
X-ME-Sender: <xms:iotpZnvM-MdtjJFhhR9DM7gCN46Xiz28vEHLpfxNlDRp8JjUIFWs-w>
    <xme:iotpZoeu_x_h6PPicGfIXjGxCyxCl_uPXw11ORhk6Ohdc9jwTKokHfKB42sUpWwgN
    NwzK1P23lYz_IREbw>
X-ME-Received: <xmr:iotpZqzxfkSwQNmYAu3zg93lnB-StlPi-53Yg03bVxqrhYrM7wHzJSZ4EbY9LJj9m4c-vbTEMK66qZqgFDAxVA00HFu0WOslRhwC-oZ0T7EGmhTk9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepvegrrhhlohhsucforghrthovnhcupfhivghtohcuoegt
    mhhnsegufihimhdrmhgvqeenucggtffrrghtthgvrhhnpefhgfffkeehtdfhueeuudduue
    ehieettddtgfeivdfhteeghfeuuedvfeegfeeivdenucffohhmrghinhephhhtthhpghhi
    thhrvghquhgvshhtshdrihhtpdhrfhhilhgvrdhrvggrugenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtmhhnsegufihimhdrmhgv
X-ME-Proxy: <xmx:iotpZmPaoG7WeiXDk9c0JVsBkeDbYxGHkaYZpgFUlIBbNCcQ-59GDw>
    <xmx:iotpZn-yOQjCfGEWzvKhBRg4rxpS0NZTm6waCiruNKWNnvSgufmcBA>
    <xmx:iotpZmW26YZ1ZraFCmPC84F55K-SmrtN2SLzQ3OwuUl_dqstr01_AQ>
    <xmx:iotpZof4Gpk5ROtgN3pEpP2TjbPldej6oK0Qhx_2YcKR5AbOHX3XUA>
    <xmx:iotpZpLwck8ujwkS2Yj8P7frxhZf-k09ZFCd2Xlnl4w9ZPysESkM4oKH>
Feedback-ID: ifc4b4307:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 07:50:34 -0400 (EDT)
Received: (nullmailer pid 1169206 invoked by uid 1000);
	Wed, 12 Jun 2024 11:50:29 -0000
From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
Subject: [PATCH 1/4] t/lib-http: add serve-git.py
Date: Wed, 12 Jun 2024 13:50:25 +0200
Message-ID: <20240612115028.1169183-2-cmn@dwim.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612115028.1169183-1-cmn@dwim.me>
References: <20240612115028.1169183-1-cmn@dwim.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a basic HTTP server that is able to serve Git content via
calling out to the underlying git commands. This avoids relying on CGI
which can add complexity when trying to replicate some behaviours, in
particular when the bidirectional stream and its directions being open
or closed are important.

Signed-off-by: Carlos Martín Nieto <cmn@dwim.me>
---
 t/lib-httpd/serve-git.py | 353 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 353 insertions(+)
 create mode 100755 t/lib-httpd/serve-git.py

diff --git a/t/lib-httpd/serve-git.py b/t/lib-httpd/serve-git.py
new file mode 100755
index 00000000000..dc2aba992d7
--- /dev/null
+++ b/t/lib-httpd/serve-git.py
@@ -0,0 +1,353 @@
+#!/usr/bin/env python3
+
+"""Serve a Git repository via unauthenticated HTTP.
+
+This script can run stand-alone but it's mostly intended to be a way to be able
+to override the Git-specific parts in order to test git against it.
+
+It also exists as an alternative to the tests that use apache to handle HTTP as
+its CGI implementation can have features or behaviours which stop us from being
+able to test everything we want to.
+
+"""
+
+import os
+import http.server
+import subprocess
+import select
+from enum import Enum
+from urllib.parse import urlparse, parse_qs, unquote
+
+RequestType = Enum('RequestType', ['UPLOAD_PACK', 'RECEIVE_PACK'])
+
+class GitHandler(http.server.BaseHTTPRequestHandler):
+    """Base handler class for serving HTTP Git requests. It will handle
+    fetches and pushes by delegating back to upload-pack and receive-pack as
+    found on its PATH.
+
+    In order to test error conditions, you can override the do_upload_pack
+    and/or do_receive_pack methods in your own class.
+
+    """
+
+    def __init__(self, document_root, *args, **kwargs):
+        self.document_root = document_root
+        super().__init__(*args, **kwargs)
+
+    # Let's not do any logging
+    def log_message(self, _fmt, *_args):
+        pass
+
+    def gitdir(self, path):
+        """Calculate the gitdir from the current directory and the given path"""
+        if path.endswith('/info/refs'):
+            path = path[:-len('/info/refs')]
+        elif path.endswith('/git-upload-pack') or path.endswith('/git-receive-pack'):
+            path = path[:-len(os.path.basename(path))]
+
+        gitdir = os.path.realpath(os.path.join(self.document_root, unquote(path[1:])))
+
+        commonprefix = os.path.commonprefix([self.document_root, os.path.join(gitdir, '')])
+        if commonprefix != self.document_root:
+            raise ValueError("request is trying to escape the document root")
+
+        return gitdir
+
+    def command_from_params(self, query_params):
+        """Returns the type of request basd on the URL query parameters"""
+        if 'git-upload-pack' in query_params['service']:
+            return RequestType.UPLOAD_PACK
+        if 'git-receive-pack' in query_params['service']:
+            return RequestType.RECEIVE_PACK
+
+        return None
+
+    def command_from_path(self, path):
+        """Returns the type of request basd on the URL path"""
+        cmd = os.path.basename(path)
+        if cmd == 'git-upload-pack':
+            return RequestType.UPLOAD_PACK
+        if cmd == 'git-receive-pack':
+            return RequestType.RECEIVE_PACK
+
+        return None
+
+    def send_git_headers(self, request_type, advertisement):
+        """Send the common HTTP headers we use"""
+        self.protocol_version = 'HTTP/1.1'
+        self.send_response(200)
+        ct = "application/x-git-upload-pack"
+        if request_type == RequestType.RECEIVE_PACK:
+            ct = "application/x-git-receive-pack"
+        if advertisement:
+            ct += "-advertisement"
+        else:
+            ct += "-result"
+
+        self.send_header('content-type', ct)
+        self.send_header('cache-control', 'no-cache')
+        self.send_header('transfer-encoding', 'chunked')
+        self.end_headers()
+
+    def respond_error(self):
+        """Generic user-caused error message"""
+        self.send_error(400)
+
+    def do_GET(self): # pylint: disable=invalid-name
+        """Handle the GET request. This is the initial one that wants the ref
+        advertisement"""
+        request = urlparse(self.path)
+        query_params = parse_qs(request.query)
+
+        gitdir = self.gitdir(request.path)
+        if not gitdir:
+            self.respond_error()
+            return
+
+        request_type = self.command_from_params(query_params)
+        protocol = self.headers['git-protocol']
+
+        responder = ChunkedResponder(self.wfile)
+
+        if request_type == RequestType.UPLOAD_PACK:
+            self.send_git_headers(request_type, True)
+            self.do_upload_pack(responder, gitdir, True, protocol)
+        elif request_type == RequestType.RECEIVE_PACK:
+            self.send_git_headers(request_type, True)
+            self.do_receive_pack(responder, gitdir, True, protocol)
+        else:
+            self.respond_error()
+
+    def do_POST(self): # pylint: disable=invalid-name
+        """Handle the POST. These requests form the negotiation and data
+        response."""
+        request = urlparse(self.path)
+
+        gitdir = self.gitdir(request.path)
+        if not gitdir:
+            self.respond_error()
+            return
+
+        request_type = self.command_from_path(request.path)
+        protocol = self.headers['git-protocol']
+
+        responder = ChunkedResponder(self.wfile)
+
+        if request_type == RequestType.UPLOAD_PACK:
+            self.send_git_headers(request_type, False)
+            self.do_upload_pack(responder, gitdir, False, protocol)
+        elif request_type == RequestType.RECEIVE_PACK:
+            self.send_git_headers(request_type, False)
+            self.do_receive_pack(responder, gitdir, False, protocol)
+        else:
+            self.respond_error()
+
+
+    def _copy_input_output(self, proc, resp):
+        """Copy the network data into the process' stdin and the process'
+        stdout to the network
+
+        """
+
+        # The stream of data we read from the client. Default to None for the
+        # GET/advertisement cases so we can override it if we're not there
+        stream = self.rfile
+        if self.headers['content-length']:
+            stream = LimitedReader(self.rfile, int(self.headers['content-length']))
+        elif self.headers['transfer-encoding'] == 'chunked':
+            stream = ChunkDecoder(self.rfile)
+
+        while True:
+            buf = stream.read(4096)
+            if len(buf) == 0:
+                break
+            try:
+                proc.stdin.write(buf)
+            except BrokenPipeError:
+                # The process has exited or closed its stdin so let's
+                # jump back out to finish copying its stdout.
+                break
+
+            r, _w, _e = select.select([proc.stdout], [], [], 0)
+            if proc.stdout in r:
+                buf = proc.stdout.read1()
+                if len(buf) > 0:
+                    resp.write(buf)
+
+    def _run_command(self, resp, command, gitdir, advertisement, protocol):
+        """Run the relevant command and copy the request body into its stdin."""
+        argv = ['git', command, '--stateless-rpc']
+        if advertisement:
+            argv.append('--advertise-refs')
+        argv.append('.')
+
+        env = {k:v for k, v in os.environ.items() if k.startswith('GIT_')}
+        if protocol is not None:
+            env['GIT_PROTOCOL'] = protocol
+
+        stdin = None
+        if not advertisement:
+            stdin = subprocess.PIPE
+
+        with subprocess.Popen(argv, stdin=stdin, stdout=subprocess.PIPE, cwd=gitdir, env=env) as proc:
+            if not advertisement:
+                self._copy_input_output(proc, resp)
+                # Close stdin so upload-pack isn't waiting forever, but if it
+                # did already die then we want to keep going anyway. We ignore
+                # the error to avoid potential race conditions, rather than try
+                # to figure out if the process has exited
+                try:
+                    proc.stdin.close()
+                except BrokenPipeError:
+                    pass
+
+            # Copy whatever the git process has output back to the client as
+            # long as it has something left to say. This covers the ref
+            # advertisement case as well as reporting errors during a push.
+            while True:
+                buf = proc.stdout.read1()
+                if len(buf) == 0:
+                    break
+                resp.write(buf)
+
+            # Close our outgoing connection
+            resp.finish()
+
+            proc.wait()
+
+    def do_upload_pack(self, resp, gitdir, advertisement, protocol):
+        """Run git-upload-pack. advertisement is True if we had a GET so we
+        need to deal with the initial ref advertisement.
+
+        Override this with your own.
+
+        """
+        if advertisement:
+            # self.send_git_heders(RequestType.UPLOAD_PACK, True)
+            resp.write(packet_line("# service=git-upload-pack\n"))
+            resp.write(b"0000")
+
+        self._run_command(resp, 'upload-pack', gitdir, advertisement, protocol)
+
+    def do_receive_pack(self, resp, gitdir, advertisement, protocol):
+        """Run git-receive-pack. advertisement is True if we had a GET so we
+        need to deal with the initial ref advertisement.
+
+        Override this with your own.
+
+        """
+        if advertisement:
+            resp.write(packet_line("# service=git-receive-pack\n"))
+            resp.write(b"0000")
+
+        self._run_command(resp, 'receive-pack', gitdir, advertisement, protocol)
+
+def packet_line(line):
+    """Format some data as a pkt-line"""
+    return f'{len(line)+4:04x}{line}'.encode('ascii')
+
+class ChunkDecoder: # pylint: disable=too-few-public-methods
+    """Decode a chunked-encoded stream of data"""
+
+    def __init__(self, rfile):
+        self.rfile = rfile
+        self.remaining = 0
+        self.finished = False
+
+    def read(self, size = -1):
+        """Read up to size bytes from the chunked stream
+
+        This function will not cross a chunk when reading.
+
+        """
+
+        if self.finished:
+            return b''
+
+        # return whatever we have up to the requested size if we're inside a chunk
+        if self.remaining > 0:
+            to_read = min(size, self.remaining)
+            buf = self.rfile.read1(to_read)
+            self.remaining -= len(buf)
+
+            # each chunk ends with CRLF so let's read it here now that we've
+            # finished reading this chunk
+            if self.remaining == 0:
+                terminator = self.rfile.read(2)
+                if terminator != b'\r\n':
+                    raise ValueError("invalid chunk terminator")
+
+            return buf
+
+        # no data left in the chunk so we have to read the next size
+        line = self.rfile.readline(16)
+        if line is None:
+            raise ValueError("invalid chunk header")
+
+        next_length = int(line, 16)
+        if next_length == 0:
+            self.finished = True
+        self.remaining = next_length
+
+        return self.read(size)
+
+class LimitedReader: # pylint: disable=too-few-public-methods
+    """Read from an underlying buffer up to a maximum size"""
+
+    def __init__(self, rfile, size):
+        self.rfile = rfile
+        self.remaining = size
+
+    def read(self, size = -1):
+        """Read up to size bytes from what is available in the input.
+
+        This function will not wait for more data in the event of a short read
+
+        """
+        if self.remaining == 0:
+            return b''
+
+        buf = self.rfile.read1(size)
+        if len(buf) == 0:
+            return b''
+
+        self.remaining -= len(buf)
+
+        return buf
+
+class ChunkedResponder:
+    """Reply with chunked encoding"""
+
+    def __init__(self, wfile):
+        self.wfile = wfile
+        self.finished = False
+
+    def finish(self):
+        """Send the final zero-length chunk header indicating we're done"""
+        if not self.finished:
+            self.wfile.write(b"0\r\n\r\n")
+            self.finished = True
+
+    def write(self, buf):
+        """Write a chunk including the size header"""
+        self.wfile.write(f"{len(buf):x}\r\n".encode('ascii'))
+        self.wfile.write(buf)
+        self.wfile.write(b"\r\n")
+
+if __name__ == "__main__":
+    import argparse
+    import functools
+
+    parser = argparse.ArgumentParser(description="Serve Git repositories over HTTP")
+    parser.add_argument('--document-root',
+                        help="Directory where the repositories live",
+                        default=os.getcwd())
+    parser.add_argument('--port',
+                        help="The port to listen on",
+                        default=8080,
+                        type=int)
+    parsed_args = parser.parse_args()
+
+    handler_partial = functools.partial(GitHandler, parsed_args.document_root)
+    httpd = http.server.HTTPServer(('', parsed_args.port), handler_partial)
+    httpd.serve_forever()
-- 
2.43.0

