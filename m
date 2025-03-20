Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF79149DFF
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742440858; cv=none; b=GSp8dcYTK2eYi5NLoyb9oMlY5swCfW5udBaNOOI9csvDdaRVRU9d0XG8ust8BPU8qtRRx10T8sIslmzmuZ91Bu0qQu3prtDdgAZDYdtHWQhhma4ntzNlEKoLE3cD2nhe/IfboxjbEiknPVQTQ/P8OOD/7Cb6jO0+n6pSm/NiolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742440858; c=relaxed/simple;
	bh=Z87PgDUnKk43g23WNnHYfbUXxWJkesKk0Y9n9A5hWBo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=YXfd741qnhWBeO+hSgg1AjF7pftP2MzxMCX7EtVthir3ZxrCaYv/KTLBU1/cCq5T19LR+Umy/IRr7ZOgn17Kso5d9ZgHqZkr4Ph1ljfAfjzlFoKYPhmWHtfwl+wrBWAs6/Vj4QNDeuYPnhDR8Ae5V8c7kk/fkntNYbdm7l1JmFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1LmwP8Y; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1LmwP8Y"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso134476f8f.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 20:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742440854; x=1743045654; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz4ni5kandXViw6Ra+F2G4MOTncqrH/8iUYTDk43EzE=;
        b=a1LmwP8YXzPcvGnlTmzfR/Cu/rUGIJ1nUSabS4GPbTqoIUB8ITSvmjhntS5SJ07o+K
         BNF5e3UxjT6gUv+qFmBOz+pvDtuGYVOpj0gaZgR/9QH7PxxRPHCJtHLXZJpYshFRH1yK
         5TAQ+GJXVITawi9ZTvVpcCisBAf72sE2Fy58kZoqjWsMR3j4zPs0nhKWBUUZGtnO9Z8f
         FJ8PMEx4FKACaJpjm3NS5F1aMC0/5ocyzonK+f3MeqMFaUyFKNL+M+9ktxOVV3Geymic
         fTlGUwnHxaCFWXX4bIPUv2JGzpsx9JXJXJ+ULH46CLq4dAQOyhs4P4f6LyJbQKAN6hcF
         6D1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742440854; x=1743045654;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rz4ni5kandXViw6Ra+F2G4MOTncqrH/8iUYTDk43EzE=;
        b=nkuhGH6/qRIDoKsW2LuiUtz2WiEcir2LQw30Z7lUJgVJQfDDprUrgnqOiKhNYQDDz4
         cysUTwodCdYWskrCtyLjZsMA3I0tYWkam/iNjavW4x+DEAET0x1fsHxzPx9tik4KW/9z
         a6McOER/ljYdEiRwgwPNfsAbhkFdtSxWKG57hWeR0t+g+D717ko42pmcxYmm4KHm8MJx
         d9wwixFC3gZj35T63dJCGkickeoeF+RBp991jSKEDCv8qI1upQLf4OWSlzYCJsLHxdkv
         GfmKCRaxUfsQ2iOpI8Mib4gksmoxMVH2xJwNyrFDDGr8O3ST3V2IgG+Sniq8of+5ODDL
         jv3w==
X-Gm-Message-State: AOJu0Yx5feIILPKOkvfo+vSpHZqmmio2xjkmszFZYw26JrSpaTMmqQ/k
	SadqGkrLXVbOHgBLkHmbimDXzbMU1ltY5w1Ydpi4QcO0bXDJxD0ds2oFow==
X-Gm-Gg: ASbGnct7zdpNh3OOXXPZ1d0GKT9eH6XgYbLMTxHlNHSclVWrfMbny1WPX+l9SYgKmXX
	pp4+PmxyC3GZmQ4nVNGwp+a2dEvq3eydpcChEHvuOXvK4jiT+OmPapez/su7wsG9KgYOfe+VN6B
	F8/cWmL3txq1aTdRYgyod4QqPiC4Rr1hXtYFm1Ob2Pom+yfJfto/iBgV/2PSuOP7IUbQpqphL/v
	gH+7AKN5nIiWbHrKOQvhfyeCo7ZyJWExFPYpZY0bas6pX4AL/rx5I5XTgXBYivgi1LpR72SStJ3
	YDlWgOzP0ItCctwYcGVnzr5Z9UZZWhU131boAzPgsWNRHYXygZaQx+F2
X-Google-Smtp-Source: AGHT+IEssCY/0oVxnzXZZ9ztTDwLPYYo8t7DHLorXHeAMpzUaHbhD+G4FC2whp2mbv6xBE5r5QKgaQ==
X-Received: by 2002:a05:6000:1868:b0:391:3207:2e6f with SMTP id ffacd0b85a97d-399795ddfb1mr1383291f8f.42.1742440854257;
        Wed, 19 Mar 2025 20:20:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a5esm22165169f8f.27.2025.03.19.20.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 20:20:53 -0700 (PDT)
Message-Id: <pull.1926.git.git.1742440852765.gitgitgadget@gmail.com>
From: "Nikolay Shustov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Mar 2025 03:20:52 +0000
Subject: [PATCH] git p4 fix for failure to decode p4 errors
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Nikolay Shustov <Nikolay.Shustov@gmail.com>,
    Nikolay Shustov <Nikolay.Shustov@gmail.com>

From: Nikolay Shustov <Nikolay.Shustov@gmail.com>

Fixes the git p4 failure happening when Perforce command returns error
containing byte stream of characters with high bit set. In such situations
git p4 implementatino fails to decode this byte stream into utf-8 string.

Design:
Make use of existing decoding fallback strategy, described by
git-p4.metadataDecodingStrategy and git-p4.metadataFallbackEncoding
settings in the logic that decodes the Perforce command error bytes.

Details:
- Moved p4 metadata transcoding logic from
  metadata_stream_to_writable_bytes(..) into a new MetadataTranscoder class.
- Enhcanced the implementation to use git-p4.metadataDecodingStrategy and
  git-p4.metadataFallbackEncoding settings for p4 errors decoding.
- Added test.

Signed-off-by: Nikolay Shustov <Nikolay.Shustov@gmail.com>
---
    git p4 fix for failure to decode p4 errors

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1926%2Fnshustov%2Fgit-p4-error-decoding-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1926/nshustov/git-p4-error-decoding-v1
Pull-Request: https://github.com/git/git/pull/1926

 git-p4.py                        | 135 ++++++++++++++++++-------------
 t/meson.build                    |   1 +
 t/t9837-git-p4-error-encoding.sh |  53 ++++++++++++
 t/t9837/git-p4-error-python3.py  |  15 ++++
 4 files changed, 149 insertions(+), 55 deletions(-)
 create mode 100755 t/t9837-git-p4-error-encoding.sh
 create mode 100644 t/t9837/git-p4-error-python3.py

diff --git a/git-p4.py b/git-p4.py
index c0ca7becaf4..72a4c55f99e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -234,67 +234,91 @@ else:
 
 
 class MetadataDecodingException(Exception):
-    def __init__(self, input_string):
+    def __init__(self, input_string, error=None):
         self.input_string = input_string
+        self.error = error
 
     def __str__(self):
-        return """Decoding perforce metadata failed!
+        message = """Decoding perforce metadata failed!
 The failing string was:
 ---
 {}
 ---
 Consider setting the git-p4.metadataDecodingStrategy config option to
 'fallback', to allow metadata to be decoded using a fallback encoding,
-defaulting to cp1252.""".format(self.input_string)
+defaulting to cp1252."""
+        if verbose and self.error is not None:
+            message += """
+---
+Error:
+---
+{}"""
+        return message.format(self.input_string, self.error)
 
 
-encoding_fallback_warning_issued = False
-encoding_escape_warning_issued = False
-def metadata_stream_to_writable_bytes(s):
-    encodingStrategy = gitConfig('git-p4.metadataDecodingStrategy') or defaultMetadataDecodingStrategy
-    fallbackEncoding = gitConfig('git-p4.metadataFallbackEncoding') or defaultFallbackMetadataEncoding
-    if not isinstance(s, bytes):
-        return s.encode('utf_8')
-    if encodingStrategy == 'passthrough':
-        return s
-    try:
-        s.decode('utf_8')
-        return s
-    except UnicodeDecodeError:
-        if encodingStrategy == 'fallback' and fallbackEncoding:
-            global encoding_fallback_warning_issued
-            global encoding_escape_warning_issued
-            try:
-                if not encoding_fallback_warning_issued:
-                    print("\nCould not decode value as utf-8; using configured fallback encoding %s: %s" % (fallbackEncoding, s))
-                    print("\n(this warning is only displayed once during an import)")
-                    encoding_fallback_warning_issued = True
-                return s.decode(fallbackEncoding).encode('utf_8')
-            except Exception as exc:
-                if not encoding_escape_warning_issued:
-                    print("\nCould not decode value with configured fallback encoding %s; escaping bytes over 127: %s" % (fallbackEncoding, s))
-                    print("\n(this warning is only displayed once during an import)")
-                    encoding_escape_warning_issued = True
-                escaped_bytes = b''
-                # bytes and strings work very differently in python2 vs python3...
-                if str is bytes:
-                    for byte in s:
-                        byte_number = struct.unpack('>B', byte)[0]
-                        if byte_number > 127:
-                            escaped_bytes += b'%'
-                            escaped_bytes += hex(byte_number)[2:].upper()
-                        else:
-                            escaped_bytes += byte
-                else:
-                    for byte_number in s:
-                        if byte_number > 127:
-                            escaped_bytes += b'%'
-                            escaped_bytes += hex(byte_number).upper().encode()[2:]
-                        else:
-                            escaped_bytes += bytes([byte_number])
-                return escaped_bytes
+class MetadataTranscoder:
+    def __init__(self, default_metadata_decoding_strategy, default_fallback_metadata_encoding):
+        self.decoding_fallback_warning_issued = False
+        self.decoding_escape_warning_issued = False
+        self.decodingStrategy = gitConfig('git-p4.metadataDecodingStrategy') or default_metadata_decoding_strategy
+        self.fallbackEncoding = gitConfig('git-p4.metadataFallbackEncoding') or default_fallback_metadata_encoding
+
+    def decode_metadata(self, s, error_from_fallback=True):
+        try:
+            return [s.decode('utf_8'), 'utf_8']
+        except UnicodeDecodeError as decode_exception:
+            error = decode_exception
+            if self.decodingStrategy == 'fallback' and self.fallbackEncoding:
+                try:
+                    if not self.decoding_fallback_warning_issued:
+                        print("\nCould not decode value as utf-8; using configured fallback encoding %s: %s" % (self.fallbackEncoding, s))
+                        print("\n(this warning is only displayed once during an import)")
+                        self.decoding_fallback_warning_issued = True
+                    return [s.decode(self.fallbackEncoding), self.fallbackEncoding]
+                except Exception as decode_exception:
+                    if not error_from_fallback:
+                        return [s, None]
+                    error = decode_exception
+            raise MetadataDecodingException(s, error)
+
+    def metadata_stream_to_writable_bytes(self, s):
+        if not isinstance(s, bytes):
+            return s.encode('utf_8')
+        if self.decodingStrategy == 'passthrough':
+            return s
+
+        [text, encoding] = self.decode_metadata(s, False)
+        if encoding == 'utf_8':
+            # s is of utf-8 already
+            return s
+
+        if encoding is None:
+            # could not decode s, even with fallback encoding
+            if not self.decoding_escape_warning_issued:
+                print("\nCould not decode value with configured fallback encoding %s; escaping bytes over 127: %s" % (self.fallbackEncoding, s))
+                print("\n(this warning is only displayed once during an import)")
+                self.decoding_escape_warning_issued = True
+            escaped_bytes = b''
+            # bytes and strings work very differently in python2 vs python3...
+            if str is bytes:
+                for byte in s:
+                    byte_number = struct.unpack('>B', byte)[0]
+                    if byte_number > 127:
+                        escaped_bytes += b'%'
+                        escaped_bytes += hex(byte_number)[2:].upper()
+                    else:
+                        escaped_bytes += byte
+            else:
+                for byte_number in s:
+                    if byte_number > 127:
+                        escaped_bytes += b'%'
+                        escaped_bytes += hex(byte_number).upper().encode()[2:]
+                    else:
+                        escaped_bytes += bytes([byte_number])
+            return escaped_bytes
 
-        raise MetadataDecodingException(s)
+        # were able to decode but not to utf-8
+        return text.encode('utf_8')
 
 
 def decode_path(path):
@@ -898,14 +922,14 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
                     decoded_entry[key] = value
                 # Parse out data if it's an error response
                 if decoded_entry.get('code') == 'error' and 'data' in decoded_entry:
-                    decoded_entry['data'] = decoded_entry['data'].decode()
+                    decoded_entry['data'] = metadataTranscoder.decode_metadata(decoded_entry['data'])
                 entry = decoded_entry
             if skip_info:
                 if 'code' in entry and entry['code'] == 'info':
                     continue
             for key in p4KeysContainingNonUtf8Chars():
                 if key in entry:
-                    entry[key] = metadata_stream_to_writable_bytes(entry[key])
+                    entry[key] = metadataTranscoder.metadata_stream_to_writable_bytes(entry[key])
             if cb is not None:
                 cb(entry)
             else:
@@ -1718,7 +1742,7 @@ class P4UserMap:
             # python2 or python3. To support
             # git-p4.metadataDecodingStrategy=fallback, self.users dict values
             # are always bytes, ready to be written to git.
-            emailbytes = metadata_stream_to_writable_bytes(output["Email"])
+            emailbytes = metadataTranscoder.metadata_stream_to_writable_bytes(output["Email"])
             self.users[output["User"]] = output["FullName"] + b" <" + emailbytes + b">"
             self.emails[output["Email"]] = output["User"]
 
@@ -1730,12 +1754,12 @@ class P4UserMap:
                 fullname = mapUser[0][1]
                 email = mapUser[0][2]
                 fulluser = fullname + " <" + email + ">"
-                self.users[user] = metadata_stream_to_writable_bytes(fulluser)
+                self.users[user] = metadataTranscoder.metadata_stream_to_writable_bytes(fulluser)
                 self.emails[email] = user
 
         s = b''
         for (key, val) in self.users.items():
-            keybytes = metadata_stream_to_writable_bytes(key)
+            keybytes = metadataTranscoder.metadata_stream_to_writable_bytes(key)
             s += b"%s\t%s\n" % (keybytes.expandtabs(1), val.expandtabs(1))
 
         open(self.getUserCacheFilename(), 'wb').write(s)
@@ -3349,7 +3373,7 @@ class P4Sync(Command, P4UserMap):
         if userid in self.users:
             return self.users[userid]
         else:
-            userid_bytes = metadata_stream_to_writable_bytes(userid)
+            userid_bytes = metadataTranscoder.metadata_stream_to_writable_bytes(userid)
             return b"%s <a@b>" % userid_bytes
 
     def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
@@ -4561,6 +4585,7 @@ commands = {
     "unshelve": P4Unshelve,
 }
 
+metadataTranscoder = MetadataTranscoder(defaultMetadataDecodingStrategy, defaultFallbackMetadataEncoding)
 
 def main():
     if len(sys.argv[1:]) == 0:
diff --git a/t/meson.build b/t/meson.build
index a59da26be3f..656424fdff3 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1090,6 +1090,7 @@ integration_tests = [
   't9834-git-p4-file-dir-bug.sh',
   't9835-git-p4-metadata-encoding-python2.sh',
   't9836-git-p4-metadata-encoding-python3.sh',
+  't9837-git-p4-error-encoding.sh',
   't9850-shell.sh',
   't9901-git-web--browse.sh',
   't9902-completion.sh',
diff --git a/t/t9837-git-p4-error-encoding.sh b/t/t9837-git-p4-error-encoding.sh
new file mode 100755
index 00000000000..1ea774afb1b
--- /dev/null
+++ b/t/t9837-git-p4-error-encoding.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+test_description='git p4 error encoding
+
+This test checks that the import process handles inconsistent text
+encoding in p4 error messages without failing'
+
+. ./lib-git-p4.sh
+
+###############################
+## SECTION REPEATED IN t9835 ##
+###############################
+
+# These tests require Perforce with non-unicode setup.
+out=$(2>&1 P4CHARSET=utf8 p4 client -o)
+if test $? -eq 0
+then
+	skip_all="skipping git p4 error encoding tests; Perforce is setup with unicode"
+	test_done
+fi
+
+# These tests are specific to Python 3. Write a custom script that executes
+# git-p4 directly with the Python 3 interpreter to ensure that we use that
+# version even if Git was compiled with Python 2.
+python_target_binary=$(which python3)
+if test -n "$python_target_binary"
+then
+	mkdir temp_python
+	PATH="$(pwd)/temp_python:$PATH"
+	export PATH
+
+	write_script temp_python/git-p4-python3 <<-EOF
+	exec "$python_target_binary" "$(git --exec-path)/git-p4" "\$@"
+	EOF
+fi
+
+git p4-python3 >err
+if ! grep 'valid commands' err
+then
+	skip_all="skipping python3 git p4 tests; python3 not available"
+	test_done
+fi
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'see if Perforce error with characters not convertable to utf-8 will be processed correctly' '
+	test_when_finished cleanup_git &&
+	$python_target_binary "$TEST_DIRECTORY"/t9837/git-p4-error-python3.py "$TEST_DIRECTORY"
+'
+
+test_done
diff --git a/t/t9837/git-p4-error-python3.py b/t/t9837/git-p4-error-python3.py
new file mode 100644
index 00000000000..fb65aee386e
--- /dev/null
+++ b/t/t9837/git-p4-error-python3.py
@@ -0,0 +1,15 @@
+import os
+import sys
+from  importlib.machinery import SourceFileLoader
+
+def main():
+    if len(sys.argv[1:]) != 1:
+        print("Expected test directory name")
+
+    gitp4_path = sys.argv[1] + "/../git-p4.py"
+    gitp4 = SourceFileLoader("gitp4", gitp4_path).load_module()
+    gitp4.p4CmdList(["edit", b'\xFEfile'])
+
+if __name__ == '__main__':
+    main()
+

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
gitgitgadget
