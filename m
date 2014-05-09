From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 15/17] contrib: remove 'persistent-https'
Date: Fri,  9 May 2014 14:11:41 -0500
Message-ID: <1399662703-355-16-git-send-email-felipe.contreras@gmail.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Colby Ranger <cranger@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 21:13:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqEJ-0002Qc-0i
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757356AbaEITMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:12:53 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:57078 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757324AbaEITMt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:12:49 -0400
Received: by mail-yh0-f53.google.com with SMTP id i57so1900023yha.40
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aMRREeMZe+XvIG8nKiXFbsLnFJwOheAz5SAks0msyrs=;
        b=PJDc4ZqYLNwS2qorxZtKySAmEZDEdBiq+v5SqwXwhgl1OCtfDdSdJ0yU7kKHu/lmcQ
         h8AgAIVxEwePqZDWGceFNR7xlH//pXy7Ox/JZ0MoSIexz+hIMpJHO2tTfDLKEJKfCHns
         KNzVb1ZbIm7AiiK5QP0Irqb65VU5EUHvKLG2UjTbvcw62xo+FUugWQmO0yQQbk1XQou6
         IXEjwKQBuWysRj8MUjyEUjcZaAFBgt0q21+LoMiqktAL4/+oNo4TsmnqDJKXhHCHknrL
         9+gcgIPhHXZZ9EGyfjrVhSIvktBJf1XDPpLWlIMmYvUXfgk4oyr5sMeTA3yWciYCWYJk
         VglQ==
X-Received: by 10.236.203.225 with SMTP id f61mr3139837yho.51.1399662768711;
        Fri, 09 May 2014 12:12:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id x61sm7417838yha.19.2014.05.09.12.12.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 12:12:47 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.28.g12374c0
In-Reply-To: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248627>

No activity. No tests.

No chance of ever moving into the core because it uses Go.

Cc: Colby Ranger <cranger@google.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/persistent-https/LICENSE   | 202 -------------------------------------
 contrib/persistent-https/Makefile  |  38 -------
 contrib/persistent-https/README    |  62 ------------
 contrib/persistent-https/client.go | 189 ----------------------------------
 contrib/persistent-https/main.go   |  82 ---------------
 contrib/persistent-https/proxy.go  | 190 ----------------------------------
 contrib/persistent-https/socket.go |  97 ------------------
 7 files changed, 860 deletions(-)
 delete mode 100644 contrib/persistent-https/LICENSE
 delete mode 100644 contrib/persistent-https/Makefile
 delete mode 100644 contrib/persistent-https/README
 delete mode 100644 contrib/persistent-https/client.go
 delete mode 100644 contrib/persistent-https/main.go
 delete mode 100644 contrib/persistent-https/proxy.go
 delete mode 100644 contrib/persistent-https/socket.go

diff --git a/contrib/persistent-https/LICENSE b/contrib/persistent-https/LICENSE
deleted file mode 100644
index d645695..0000000
--- a/contrib/persistent-https/LICENSE
+++ /dev/null
@@ -1,202 +0,0 @@
-
-                                 Apache License
-                           Version 2.0, January 2004
-                        http://www.apache.org/licenses/
-
-   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION
-
-   1. Definitions.
-
-      "License" shall mean the terms and conditions for use, reproduction,
-      and distribution as defined by Sections 1 through 9 of this document.
-
-      "Licensor" shall mean the copyright owner or entity authorized by
-      the copyright owner that is granting the License.
-
-      "Legal Entity" shall mean the union of the acting entity and all
-      other entities that control, are controlled by, or are under common
-      control with that entity. For the purposes of this definition,
-      "control" means (i) the power, direct or indirect, to cause the
-      direction or management of such entity, whether by contract or
-      otherwise, or (ii) ownership of fifty percent (50%) or more of the
-      outstanding shares, or (iii) beneficial ownership of such entity.
-
-      "You" (or "Your") shall mean an individual or Legal Entity
-      exercising permissions granted by this License.
-
-      "Source" form shall mean the preferred form for making modifications,
-      including but not limited to software source code, documentation
-      source, and configuration files.
-
-      "Object" form shall mean any form resulting from mechanical
-      transformation or translation of a Source form, including but
-      not limited to compiled object code, generated documentation,
-      and conversions to other media types.
-
-      "Work" shall mean the work of authorship, whether in Source or
-      Object form, made available under the License, as indicated by a
-      copyright notice that is included in or attached to the work
-      (an example is provided in the Appendix below).
-
-      "Derivative Works" shall mean any work, whether in Source or Object
-      form, that is based on (or derived from) the Work and for which the
-      editorial revisions, annotations, elaborations, or other modifications
-      represent, as a whole, an original work of authorship. For the purposes
-      of this License, Derivative Works shall not include works that remain
-      separable from, or merely link (or bind by name) to the interfaces of,
-      the Work and Derivative Works thereof.
-
-      "Contribution" shall mean any work of authorship, including
-      the original version of the Work and any modifications or additions
-      to that Work or Derivative Works thereof, that is intentionally
-      submitted to Licensor for inclusion in the Work by the copyright owner
-      or by an individual or Legal Entity authorized to submit on behalf of
-      the copyright owner. For the purposes of this definition, "submitted"
-      means any form of electronic, verbal, or written communication sent
-      to the Licensor or its representatives, including but not limited to
-      communication on electronic mailing lists, source code control systems,
-      and issue tracking systems that are managed by, or on behalf of, the
-      Licensor for the purpose of discussing and improving the Work, but
-      excluding communication that is conspicuously marked or otherwise
-      designated in writing by the copyright owner as "Not a Contribution."
-
-      "Contributor" shall mean Licensor and any individual or Legal Entity
-      on behalf of whom a Contribution has been received by Licensor and
-      subsequently incorporated within the Work.
-
-   2. Grant of Copyright License. Subject to the terms and conditions of
-      this License, each Contributor hereby grants to You a perpetual,
-      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
-      copyright license to reproduce, prepare Derivative Works of,
-      publicly display, publicly perform, sublicense, and distribute the
-      Work and such Derivative Works in Source or Object form.
-
-   3. Grant of Patent License. Subject to the terms and conditions of
-      this License, each Contributor hereby grants to You a perpetual,
-      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
-      (except as stated in this section) patent license to make, have made,
-      use, offer to sell, sell, import, and otherwise transfer the Work,
-      where such license applies only to those patent claims licensable
-      by such Contributor that are necessarily infringed by their
-      Contribution(s) alone or by combination of their Contribution(s)
-      with the Work to which such Contribution(s) was submitted. If You
-      institute patent litigation against any entity (including a
-      cross-claim or counterclaim in a lawsuit) alleging that the Work
-      or a Contribution incorporated within the Work constitutes direct
-      or contributory patent infringement, then any patent licenses
-      granted to You under this License for that Work shall terminate
-      as of the date such litigation is filed.
-
-   4. Redistribution. You may reproduce and distribute copies of the
-      Work or Derivative Works thereof in any medium, with or without
-      modifications, and in Source or Object form, provided that You
-      meet the following conditions:
-
-      (a) You must give any other recipients of the Work or
-          Derivative Works a copy of this License; and
-
-      (b) You must cause any modified files to carry prominent notices
-          stating that You changed the files; and
-
-      (c) You must retain, in the Source form of any Derivative Works
-          that You distribute, all copyright, patent, trademark, and
-          attribution notices from the Source form of the Work,
-          excluding those notices that do not pertain to any part of
-          the Derivative Works; and
-
-      (d) If the Work includes a "NOTICE" text file as part of its
-          distribution, then any Derivative Works that You distribute must
-          include a readable copy of the attribution notices contained
-          within such NOTICE file, excluding those notices that do not
-          pertain to any part of the Derivative Works, in at least one
-          of the following places: within a NOTICE text file distributed
-          as part of the Derivative Works; within the Source form or
-          documentation, if provided along with the Derivative Works; or,
-          within a display generated by the Derivative Works, if and
-          wherever such third-party notices normally appear. The contents
-          of the NOTICE file are for informational purposes only and
-          do not modify the License. You may add Your own attribution
-          notices within Derivative Works that You distribute, alongside
-          or as an addendum to the NOTICE text from the Work, provided
-          that such additional attribution notices cannot be construed
-          as modifying the License.
-
-      You may add Your own copyright statement to Your modifications and
-      may provide additional or different license terms and conditions
-      for use, reproduction, or distribution of Your modifications, or
-      for any such Derivative Works as a whole, provided Your use,
-      reproduction, and distribution of the Work otherwise complies with
-      the conditions stated in this License.
-
-   5. Submission of Contributions. Unless You explicitly state otherwise,
-      any Contribution intentionally submitted for inclusion in the Work
-      by You to the Licensor shall be under the terms and conditions of
-      this License, without any additional terms or conditions.
-      Notwithstanding the above, nothing herein shall supersede or modify
-      the terms of any separate license agreement you may have executed
-      with Licensor regarding such Contributions.
-
-   6. Trademarks. This License does not grant permission to use the trade
-      names, trademarks, service marks, or product names of the Licensor,
-      except as required for reasonable and customary use in describing the
-      origin of the Work and reproducing the content of the NOTICE file.
-
-   7. Disclaimer of Warranty. Unless required by applicable law or
-      agreed to in writing, Licensor provides the Work (and each
-      Contributor provides its Contributions) on an "AS IS" BASIS,
-      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
-      implied, including, without limitation, any warranties or conditions
-      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
-      PARTICULAR PURPOSE. You are solely responsible for determining the
-      appropriateness of using or redistributing the Work and assume any
-      risks associated with Your exercise of permissions under this License.
-
-   8. Limitation of Liability. In no event and under no legal theory,
-      whether in tort (including negligence), contract, or otherwise,
-      unless required by applicable law (such as deliberate and grossly
-      negligent acts) or agreed to in writing, shall any Contributor be
-      liable to You for damages, including any direct, indirect, special,
-      incidental, or consequential damages of any character arising as a
-      result of this License or out of the use or inability to use the
-      Work (including but not limited to damages for loss of goodwill,
-      work stoppage, computer failure or malfunction, or any and all
-      other commercial damages or losses), even if such Contributor
-      has been advised of the possibility of such damages.
-
-   9. Accepting Warranty or Additional Liability. While redistributing
-      the Work or Derivative Works thereof, You may choose to offer,
-      and charge a fee for, acceptance of support, warranty, indemnity,
-      or other liability obligations and/or rights consistent with this
-      License. However, in accepting such obligations, You may act only
-      on Your own behalf and on Your sole responsibility, not on behalf
-      of any other Contributor, and only if You agree to indemnify,
-      defend, and hold each Contributor harmless for any liability
-      incurred by, or claims asserted against, such Contributor by reason
-      of your accepting any such warranty or additional liability.
-
-   END OF TERMS AND CONDITIONS
-
-   APPENDIX: How to apply the Apache License to your work.
-
-      To apply the Apache License to your work, attach the following
-      boilerplate notice, with the fields enclosed by brackets "[]"
-      replaced with your own identifying information. (Don't include
-      the brackets!)  The text should be enclosed in the appropriate
-      comment syntax for the file format. We also recommend that a
-      file or class name and description of purpose be included on the
-      same "printed page" as the copyright notice for easier
-      identification within third-party archives.
-
-   Copyright [yyyy] [name of copyright owner]
-
-   Licensed under the Apache License, Version 2.0 (the "License");
-   you may not use this file except in compliance with the License.
-   You may obtain a copy of the License at
-
-       http://www.apache.org/licenses/LICENSE-2.0
-
-   Unless required by applicable law or agreed to in writing, software
-   distributed under the License is distributed on an "AS IS" BASIS,
-   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-   See the License for the specific language governing permissions and
-   limitations under the License.
diff --git a/contrib/persistent-https/Makefile b/contrib/persistent-https/Makefile
deleted file mode 100644
index 92baa3b..0000000
--- a/contrib/persistent-https/Makefile
+++ /dev/null
@@ -1,38 +0,0 @@
-# Copyright 2012 Google Inc. All Rights Reserved.
-#
-# Licensed under the Apache License, Version 2.0 (the "License");
-# you may not use this file except in compliance with the License.
-# You may obtain a copy of the License at
-#
-#     http://www.apache.org/licenses/LICENSE-2.0
-#
-# Unless required by applicable law or agreed to in writing, software
-# distributed under the License is distributed on an "AS IS" BASIS,
-# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-# See the License for the specific language governing permissions and
-# limitations under the License.
-
-BUILD_LABEL=$(shell date +"%s")
-TAR_OUT=$(shell go env GOOS)_$(shell go env GOARCH).tar.gz
-
-all: git-remote-persistent-https git-remote-persistent-https--proxy \
-	git-remote-persistent-http
-
-git-remote-persistent-https--proxy: git-remote-persistent-https
-	ln -f -s git-remote-persistent-https git-remote-persistent-https--proxy
-
-git-remote-persistent-http: git-remote-persistent-https
-	ln -f -s git-remote-persistent-https git-remote-persistent-http
-
-git-remote-persistent-https:
-	go build -o git-remote-persistent-https \
-		-ldflags "-X main._BUILD_EMBED_LABEL $(BUILD_LABEL)"
-
-clean:
-	rm -f git-remote-persistent-http* *.tar.gz
-
-tar: clean all
-	@chmod 555 git-remote-persistent-https
-	@tar -czf $(TAR_OUT) git-remote-persistent-http* README LICENSE
-	@echo
-	@echo "Created $(TAR_OUT)"
diff --git a/contrib/persistent-https/README b/contrib/persistent-https/README
deleted file mode 100644
index f784dd2..0000000
--- a/contrib/persistent-https/README
+++ /dev/null
@@ -1,62 +0,0 @@
-git-remote-persistent-https
-
-The git-remote-persistent-https binary speeds up SSL operations
-by running a daemon job (git-remote-persistent-https--proxy) that
-keeps a connection open to a server.
-
-
-PRE-BUILT BINARIES
-
-Darwin amd64:
-https://commondatastorage.googleapis.com/git-remote-persistent-https/darwin_amd64.tar.gz
-
-Linux amd64:
-https://commondatastorage.googleapis.com/git-remote-persistent-https/linux_amd64.tar.gz
-
-
-INSTALLING
-
-Move all of the git-remote-persistent-http* binaries to a directory
-in PATH.
-
-
-USAGE
-
-HTTPS requests can be delegated to the proxy by using the
-"persistent-https" scheme, e.g.
-
-git clone persistent-https://kernel.googlesource.com/pub/scm/git/git
-
-Likewise, .gitconfig can be updated as follows to rewrite https urls
-to use persistent-https:
-
-[url "persistent-https"]
-	insteadof = https
-[url "persistent-http"]
-	insteadof = http
-
-
-#####################################################################
-# BUILDING FROM SOURCE
-#####################################################################
-
-LOCATION
-
-The source is available in the contrib/persistent-https directory of
-the Git source repository. The Git source repository is available at
-git://git.kernel.org/pub/scm/git/git.git/
-https://kernel.googlesource.com/pub/scm/git/git
-
-
-PREREQUISITES
-
-The code is written in Go (http://golang.org/) and the Go compiler is
-required. Currently, the compiler must be built and installed from tip
-of source, in order to include a fix in the reverse http proxy:
-http://code.google.com/p/go/source/detail?r=a615b796570a2cd8591884767a7d67ede74f6648
-
-
-BUILDING
-
-Run "make" to build the binaries. See the section on
-INSTALLING above.
diff --git a/contrib/persistent-https/client.go b/contrib/persistent-https/client.go
deleted file mode 100644
index 71125b5..0000000
--- a/contrib/persistent-https/client.go
+++ /dev/null
@@ -1,189 +0,0 @@
-// Copyright 2012 Google Inc. All Rights Reserved.
-//
-// Licensed under the Apache License, Version 2.0 (the "License");
-// you may not use this file except in compliance with the License.
-// You may obtain a copy of the License at
-//
-//     http://www.apache.org/licenses/LICENSE-2.0
-//
-// Unless required by applicable law or agreed to in writing, software
-// distributed under the License is distributed on an "AS IS" BASIS,
-// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-// See the License for the specific language governing permissions and
-// limitations under the License.
-
-package main
-
-import (
-	"bufio"
-	"errors"
-	"fmt"
-	"net"
-	"net/url"
-	"os"
-	"os/exec"
-	"strings"
-	"syscall"
-	"time"
-)
-
-type Client struct {
-	ProxyBin string
-	Args     []string
-
-	insecure bool
-}
-
-func (c *Client) Run() error {
-	if err := c.resolveArgs(); err != nil {
-		return fmt.Errorf("resolveArgs() got error: %v", err)
-	}
-
-	// Connect to the proxy.
-	uconn, hconn, addr, err := c.connect()
-	if err != nil {
-		return fmt.Errorf("connect() got error: %v", err)
-	}
-	// Keep the unix socket connection open for the duration of the request.
-	defer uconn.Close()
-	// Keep a connection to the HTTP server open, so no other user can
-	// bind on the same address so long as the process is running.
-	defer hconn.Close()
-
-	// Start the git-remote-http subprocess.
-	cargs := []string{"-c", fmt.Sprintf("http.proxy=%v", addr), "remote-http"}
-	cargs = append(cargs, c.Args...)
-	cmd := exec.Command("git", cargs...)
-
-	for _, v := range os.Environ() {
-		if !strings.HasPrefix(v, "GIT_PERSISTENT_HTTPS_SECURE=") {
-			cmd.Env = append(cmd.Env, v)
-		}
-	}
-	// Set the GIT_PERSISTENT_HTTPS_SECURE environment variable when
-	// the proxy is using a SSL connection.  This allows credential helpers
-	// to identify secure proxy connections, despite being passed an HTTP
-	// scheme.
-	if !c.insecure {
-		cmd.Env = append(cmd.Env, "GIT_PERSISTENT_HTTPS_SECURE=1")
-	}
-
-	cmd.Stdin = os.Stdin
-	cmd.Stdout = os.Stdout
-	cmd.Stderr = os.Stderr
-	if err := cmd.Run(); err != nil {
-		if eerr, ok := err.(*exec.ExitError); ok {
-			if stat, ok := eerr.ProcessState.Sys().(syscall.WaitStatus); ok && stat.ExitStatus() != 0 {
-				os.Exit(stat.ExitStatus())
-			}
-		}
-		return fmt.Errorf("git-remote-http subprocess got error: %v", err)
-	}
-	return nil
-}
-
-func (c *Client) connect() (uconn net.Conn, hconn net.Conn, addr string, err error) {
-	uconn, err = DefaultSocket.Dial()
-	if err != nil {
-		if e, ok := err.(*net.OpError); ok && (os.IsNotExist(e.Err) || e.Err == syscall.ECONNREFUSED) {
-			if err = c.startProxy(); err == nil {
-				uconn, err = DefaultSocket.Dial()
-			}
-		}
-		if err != nil {
-			return
-		}
-	}
-
-	if addr, err = c.readAddr(uconn); err != nil {
-		return
-	}
-
-	// Open a tcp connection to the proxy.
-	if hconn, err = net.Dial("tcp", addr); err != nil {
-		return
-	}
-
-	// Verify the address hasn't changed ownership.
-	var addr2 string
-	if addr2, err = c.readAddr(uconn); err != nil {
-		return
-	} else if addr != addr2 {
-		err = fmt.Errorf("address changed after connect. got %q, want %q", addr2, addr)
-		return
-	}
-	return
-}
-
-func (c *Client) readAddr(conn net.Conn) (string, error) {
-	conn.SetDeadline(time.Now().Add(5 * time.Second))
-	data := make([]byte, 100)
-	n, err := conn.Read(data)
-	if err != nil {
-		return "", fmt.Errorf("error reading unix socket: %v", err)
-	} else if n == 0 {
-		return "", errors.New("empty data response")
-	}
-	conn.Write([]byte{1}) // Ack
-
-	var addr string
-	if addrs := strings.Split(string(data[:n]), "\n"); len(addrs) != 2 {
-		return "", fmt.Errorf("got %q, wanted 2 addresses", data[:n])
-	} else if c.insecure {
-		addr = addrs[1]
-	} else {
-		addr = addrs[0]
-	}
-	return addr, nil
-}
-
-func (c *Client) startProxy() error {
-	cmd := exec.Command(c.ProxyBin)
-	cmd.SysProcAttr = &syscall.SysProcAttr{Setpgid: true}
-	stdout, err := cmd.StdoutPipe()
-	if err != nil {
-		return err
-	}
-	defer stdout.Close()
-	if err := cmd.Start(); err != nil {
-		return err
-	}
-	result := make(chan error)
-	go func() {
-		bytes, _, err := bufio.NewReader(stdout).ReadLine()
-		if line := string(bytes); err == nil && line != "OK" {
-			err = fmt.Errorf("proxy returned %q, want \"OK\"", line)
-		}
-		result <- err
-	}()
-	select {
-	case err := <-result:
-		return err
-	case <-time.After(5 * time.Second):
-		return errors.New("timeout waiting for proxy to start")
-	}
-	panic("not reachable")
-}
-
-func (c *Client) resolveArgs() error {
-	if nargs := len(c.Args); nargs == 0 {
-		return errors.New("remote needed")
-	} else if nargs > 2 {
-		return fmt.Errorf("want at most 2 args, got %v", c.Args)
-	}
-
-	// Rewrite the url scheme to be http.
-	idx := len(c.Args) - 1
-	rawurl := c.Args[idx]
-	rurl, err := url.Parse(rawurl)
-	if err != nil {
-		return fmt.Errorf("invalid remote: %v", err)
-	}
-	c.insecure = rurl.Scheme == "persistent-http"
-	rurl.Scheme = "http"
-	c.Args[idx] = rurl.String()
-	if idx != 0 && c.Args[0] == rawurl {
-		c.Args[0] = c.Args[idx]
-	}
-	return nil
-}
diff --git a/contrib/persistent-https/main.go b/contrib/persistent-https/main.go
deleted file mode 100644
index fd1b107..0000000
--- a/contrib/persistent-https/main.go
+++ /dev/null
@@ -1,82 +0,0 @@
-// Copyright 2012 Google Inc. All Rights Reserved.
-//
-// Licensed under the Apache License, Version 2.0 (the "License");
-// you may not use this file except in compliance with the License.
-// You may obtain a copy of the License at
-//
-//     http://www.apache.org/licenses/LICENSE-2.0
-//
-// Unless required by applicable law or agreed to in writing, software
-// distributed under the License is distributed on an "AS IS" BASIS,
-// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-// See the License for the specific language governing permissions and
-// limitations under the License.
-
-// The git-remote-persistent-https binary speeds up SSL operations by running
-// a daemon job that keeps a connection open to a Git server. This ensures the
-// git-remote-persistent-https--proxy is running and delegating execution
-// to the git-remote-http binary with the http_proxy set to the daemon job.
-// A unix socket is used to authenticate the proxy and discover the
-// HTTP address. Note, both the client and proxy are included in the same
-// binary.
-package main
-
-import (
-	"flag"
-	"fmt"
-	"log"
-	"os"
-	"strings"
-	"time"
-)
-
-var (
-	forceProxy = flag.Bool("proxy", false, "Whether to start the binary in proxy mode")
-	proxyBin   = flag.String("proxy_bin", "git-remote-persistent-https--proxy", "Path to the proxy binary")
-	printLabel = flag.Bool("print_label", false, "Prints the build label for the binary")
-
-	// Variable that should be defined through the -X linker flag.
-	_BUILD_EMBED_LABEL string
-)
-
-const (
-	defaultMaxIdleDuration    = 24 * time.Hour
-	defaultPollUpdateInterval = 15 * time.Minute
-)
-
-func main() {
-	flag.Parse()
-	if *printLabel {
-		// Short circuit execution to print the build label
-		fmt.Println(buildLabel())
-		return
-	}
-
-	var err error
-	if *forceProxy || strings.HasSuffix(os.Args[0], "--proxy") {
-		log.SetPrefix("git-remote-persistent-https--proxy: ")
-		proxy := &Proxy{
-			BuildLabel:         buildLabel(),
-			MaxIdleDuration:    defaultMaxIdleDuration,
-			PollUpdateInterval: defaultPollUpdateInterval,
-		}
-		err = proxy.Run()
-	} else {
-		log.SetPrefix("git-remote-persistent-https: ")
-		client := &Client{
-			ProxyBin: *proxyBin,
-			Args:     flag.Args(),
-		}
-		err = client.Run()
-	}
-	if err != nil {
-		log.Fatalln(err)
-	}
-}
-
-func buildLabel() string {
-	if _BUILD_EMBED_LABEL == "" {
-		log.Println(`unlabeled build; build with "make" to label`)
-	}
-	return _BUILD_EMBED_LABEL
-}
diff --git a/contrib/persistent-https/proxy.go b/contrib/persistent-https/proxy.go
deleted file mode 100644
index bb0cdba..0000000
--- a/contrib/persistent-https/proxy.go
+++ /dev/null
@@ -1,190 +0,0 @@
-// Copyright 2012 Google Inc. All Rights Reserved.
-//
-// Licensed under the Apache License, Version 2.0 (the "License");
-// you may not use this file except in compliance with the License.
-// You may obtain a copy of the License at
-//
-//     http://www.apache.org/licenses/LICENSE-2.0
-//
-// Unless required by applicable law or agreed to in writing, software
-// distributed under the License is distributed on an "AS IS" BASIS,
-// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-// See the License for the specific language governing permissions and
-// limitations under the License.
-
-package main
-
-import (
-	"fmt"
-	"log"
-	"net"
-	"net/http"
-	"net/http/httputil"
-	"os"
-	"os/exec"
-	"os/signal"
-	"sync"
-	"syscall"
-	"time"
-)
-
-type Proxy struct {
-	BuildLabel         string
-	MaxIdleDuration    time.Duration
-	PollUpdateInterval time.Duration
-
-	ul        net.Listener
-	httpAddr  string
-	httpsAddr string
-}
-
-func (p *Proxy) Run() error {
-	hl, err := net.Listen("tcp", "127.0.0.1:0")
-	if err != nil {
-		return fmt.Errorf("http listen failed: %v", err)
-	}
-	defer hl.Close()
-
-	hsl, err := net.Listen("tcp", "127.0.0.1:0")
-	if err != nil {
-		return fmt.Errorf("https listen failed: %v", err)
-	}
-	defer hsl.Close()
-
-	p.ul, err = DefaultSocket.Listen()
-	if err != nil {
-		c, derr := DefaultSocket.Dial()
-		if derr == nil {
-			c.Close()
-			fmt.Println("OK\nA proxy is already running... exiting")
-			return nil
-		} else if e, ok := derr.(*net.OpError); ok && e.Err == syscall.ECONNREFUSED {
-			// Nothing is listening on the socket, unlink it and try again.
-			syscall.Unlink(DefaultSocket.Path())
-			p.ul, err = DefaultSocket.Listen()
-		}
-		if err != nil {
-			return fmt.Errorf("unix listen failed on %v: %v", DefaultSocket.Path(), err)
-		}
-	}
-	defer p.ul.Close()
-	go p.closeOnSignal()
-	go p.closeOnUpdate()
-
-	p.httpAddr = hl.Addr().String()
-	p.httpsAddr = hsl.Addr().String()
-	fmt.Printf("OK\nListening on unix socket=%v http=%v https=%v\n",
-		p.ul.Addr(), p.httpAddr, p.httpsAddr)
-
-	result := make(chan error, 2)
-	go p.serveUnix(result)
-	go func() {
-		result <- http.Serve(hl, &httputil.ReverseProxy{
-			FlushInterval: 500 * time.Millisecond,
-			Director:      func(r *http.Request) {},
-		})
-	}()
-	go func() {
-		result <- http.Serve(hsl, &httputil.ReverseProxy{
-			FlushInterval: 500 * time.Millisecond,
-			Director: func(r *http.Request) {
-				r.URL.Scheme = "https"
-			},
-		})
-	}()
-	return <-result
-}
-
-type socketContext struct {
-	sync.WaitGroup
-	mutex sync.Mutex
-	last  time.Time
-}
-
-func (sc *socketContext) Done() {
-	sc.mutex.Lock()
-	defer sc.mutex.Unlock()
-	sc.last = time.Now()
-	sc.WaitGroup.Done()
-}
-
-func (p *Proxy) serveUnix(result chan<- error) {
-	sockCtx := &socketContext{}
-	go p.closeOnIdle(sockCtx)
-
-	var err error
-	for {
-		var uconn net.Conn
-		uconn, err = p.ul.Accept()
-		if err != nil {
-			err = fmt.Errorf("accept failed: %v", err)
-			break
-		}
-		sockCtx.Add(1)
-		go p.handleUnixConn(sockCtx, uconn)
-	}
-	sockCtx.Wait()
-	result <- err
-}
-
-func (p *Proxy) handleUnixConn(sockCtx *socketContext, uconn net.Conn) {
-	defer sockCtx.Done()
-	defer uconn.Close()
-	data := []byte(fmt.Sprintf("%v\n%v", p.httpsAddr, p.httpAddr))
-	uconn.SetDeadline(time.Now().Add(5 * time.Second))
-	for i := 0; i < 2; i++ {
-		if n, err := uconn.Write(data); err != nil {
-			log.Printf("error sending http addresses: %+v\n", err)
-			return
-		} else if n != len(data) {
-			log.Printf("sent %d data bytes, wanted %d\n", n, len(data))
-			return
-		}
-		if _, err := uconn.Read([]byte{0, 0, 0, 0}); err != nil {
-			log.Printf("error waiting for Ack: %+v\n", err)
-			return
-		}
-	}
-	// Wait without a deadline for the client to finish via EOF
-	uconn.SetDeadline(time.Time{})
-	uconn.Read([]byte{0, 0, 0, 0})
-}
-
-func (p *Proxy) closeOnIdle(sockCtx *socketContext) {
-	for d := p.MaxIdleDuration; d > 0; {
-		time.Sleep(d)
-		sockCtx.Wait()
-		sockCtx.mutex.Lock()
-		if d = sockCtx.last.Add(p.MaxIdleDuration).Sub(time.Now()); d <= 0 {
-			log.Println("graceful shutdown from idle timeout")
-			p.ul.Close()
-		}
-		sockCtx.mutex.Unlock()
-	}
-}
-
-func (p *Proxy) closeOnUpdate() {
-	for {
-		time.Sleep(p.PollUpdateInterval)
-		if out, err := exec.Command(os.Args[0], "--print_label").Output(); err != nil {
-			log.Printf("error polling for updated binary: %v\n", err)
-		} else if s := string(out[:len(out)-1]); p.BuildLabel != s {
-			log.Printf("graceful shutdown from updated binary: %q --> %q\n", p.BuildLabel, s)
-			p.ul.Close()
-			break
-		}
-	}
-}
-
-func (p *Proxy) closeOnSignal() {
-	ch := make(chan os.Signal, 10)
-	signal.Notify(ch, os.Interrupt, os.Kill, os.Signal(syscall.SIGTERM), os.Signal(syscall.SIGHUP))
-	sig := <-ch
-	p.ul.Close()
-	switch sig {
-	case os.Signal(syscall.SIGHUP):
-		log.Printf("graceful shutdown from signal: %v\n", sig)
-	default:
-		log.Fatalf("exiting from signal: %v\n", sig)
-	}
-}
diff --git a/contrib/persistent-https/socket.go b/contrib/persistent-https/socket.go
deleted file mode 100644
index 193b911..0000000
--- a/contrib/persistent-https/socket.go
+++ /dev/null
@@ -1,97 +0,0 @@
-// Copyright 2012 Google Inc. All Rights Reserved.
-//
-// Licensed under the Apache License, Version 2.0 (the "License");
-// you may not use this file except in compliance with the License.
-// You may obtain a copy of the License at
-//
-//     http://www.apache.org/licenses/LICENSE-2.0
-//
-// Unless required by applicable law or agreed to in writing, software
-// distributed under the License is distributed on an "AS IS" BASIS,
-// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-// See the License for the specific language governing permissions and
-// limitations under the License.
-
-package main
-
-import (
-	"fmt"
-	"log"
-	"net"
-	"os"
-	"path/filepath"
-	"syscall"
-)
-
-// A Socket is a wrapper around a Unix socket that verifies directory
-// permissions.
-type Socket struct {
-	Dir string
-}
-
-func defaultDir() string {
-	sockPath := ".git-credential-cache"
-	if home := os.Getenv("HOME"); home != "" {
-		return filepath.Join(home, sockPath)
-	}
-	log.Printf("socket: cannot find HOME path. using relative directory %q for socket", sockPath)
-	return sockPath
-}
-
-// DefaultSocket is a Socket in the $HOME/.git-credential-cache directory.
-var DefaultSocket = Socket{Dir: defaultDir()}
-
-// Listen announces the local network address of the unix socket. The
-// permissions on the socket directory are verified before attempting
-// the actual listen.
-func (s Socket) Listen() (net.Listener, error) {
-	network, addr := "unix", s.Path()
-	if err := s.mkdir(); err != nil {
-		return nil, &net.OpError{Op: "listen", Net: network, Addr: &net.UnixAddr{Name: addr, Net: network}, Err: err}
-	}
-	return net.Listen(network, addr)
-}
-
-// Dial connects to the unix socket. The permissions on the socket directory
-// are verified before attempting the actual dial.
-func (s Socket) Dial() (net.Conn, error) {
-	network, addr := "unix", s.Path()
-	if err := s.checkPermissions(); err != nil {
-		return nil, &net.OpError{Op: "dial", Net: network, Addr: &net.UnixAddr{Name: addr, Net: network}, Err: err}
-	}
-	return net.Dial(network, addr)
-}
-
-// Path returns the fully specified file name of the unix socket.
-func (s Socket) Path() string {
-	return filepath.Join(s.Dir, "persistent-https-proxy-socket")
-}
-
-func (s Socket) mkdir() error {
-	if err := s.checkPermissions(); err == nil {
-		return nil
-	} else if !os.IsNotExist(err) {
-		return err
-	}
-	if err := os.MkdirAll(s.Dir, 0700); err != nil {
-		return err
-	}
-	return s.checkPermissions()
-}
-
-func (s Socket) checkPermissions() error {
-	fi, err := os.Stat(s.Dir)
-	if err != nil {
-		return err
-	}
-	if !fi.IsDir() {
-		return fmt.Errorf("socket: got file, want directory for %q", s.Dir)
-	}
-	if fi.Mode().Perm() != 0700 {
-		return fmt.Errorf("socket: got perm %o, want 700 for %q", fi.Mode().Perm(), s.Dir)
-	}
-	if st := fi.Sys().(*syscall.Stat_t); int(st.Uid) != os.Getuid() {
-		return fmt.Errorf("socket: got uid %d, want %d for %q", st.Uid, os.Getuid(), s.Dir)
-	}
-	return nil
-}
-- 
1.9.2+fc1.28.g12374c0
