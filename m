Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40039C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 09:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64FF224F8
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 09:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="iqwwTjMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfLEJyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:54:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39350 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfLEJyl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 04:54:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so2896619wmh.4
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 01:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lRAY94NwvbsPmO6zFfL7gmShzpglxhBM7MLzJm3HmnM=;
        b=iqwwTjMh7fFVziZkAMI8m6Z7YPh8TayWYpdHgEuOFWga7q86lA7EHjV3qNrDC7ZikE
         uyc7mW8Zi8jRftD0ICDTEm9852tG8d2kOXUBYtdX8UbvCFE//7UKnUf6LXpF6mSw6sXa
         DBhapGIFpeOd/VxULIhyQKMUCgM1tBk8gf2iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lRAY94NwvbsPmO6zFfL7gmShzpglxhBM7MLzJm3HmnM=;
        b=QR7+WpLcjRAZZiv8h1OyEuDIlwBhlOn35ZEW0pTjvZyWkFjsZMnLJ4zGoE013uNdQB
         qp7mdbCyirMR8q/ZnjMsx9IsSIKlUknNrMpEwbA41mYBfWQyAAdryCDEaDlF3P9os+jG
         tpENWv6yj6UzI6wp6L9svtQtq7y80zsp3vhExyLCtUhhad5ye5ocs+npJJewhFFQG6Xg
         qzHmWCO/hOFeJRsU1mi9JZUfE9n9RgHumwC/VTbR/0japQYz1JBbSE6R2g8BXJWL0+O+
         tEEj2vORa3064ChkhZspd7APw4nnhoa1f7eAvTkXgR94+teBSHVMR3eOOusryi2vrrQP
         ZyKw==
X-Gm-Message-State: APjAAAUiZMAg0rZsRK4CQz07TRb8b7bNmlTymi1l87tMgJ9KyVLCxNbY
        0OlGDq0w/SMaD7sLmdI5BGBtq1QY+vI5qbVnlTLrVQ==
X-Google-Smtp-Source: APXvYqwVX9+7GiDFYvH6aZ03vpZtMotvVVqGYr5gJkyTR2VD3UtXMONPQCbPEoIePhsoXKysGYSL9VVW9pRFJx24e/w=
X-Received: by 2002:a7b:c389:: with SMTP id s9mr4175595wmj.7.1575539675414;
 Thu, 05 Dec 2019 01:54:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com> <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Thu, 5 Dec 2019 09:54:27 +0000
Message-ID: <CAE5ih7-6EbEM4z5BtY87=82H_tLypiOPq4WY5mm3190QExTZWQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] git-p4.py: Cast byte strings to unicode strings
 in python3
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 4 Dec 2019 at 22:29, Ben Keene via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Issue: The current git-p4.py script does not work with python3.
>
> I have attempted to use the P4 integration built into GIT and I was unabl=
e
> to get the program to run because I have Python 3.8 installed on my
> computer. I was able to get the program to run when I downgraded my pytho=
n
> to version 2.7. However, python 2 is reaching its end of life.
>
> Submission: I am submitting a patch for the git-p4.py script that partial=
ly
> supports python 3.8. This code was able to pass the basic tests (t9800) w=
hen
> run against Python3. This provides basic functionality.
>
> In an attempt to pass the t9822 P4 path-encoding test, a new parameter fo=
r
> git P4 Clone was introduced.
>
> --encoding Format-identifier
>
> This will create the GIT repository following the current functionality;
> however, before importing the files from P4, it will set the
> git-p4.pathEncoding option so any files or paths that are encoded with
> non-ASCII/non-UTF-8 formats will import correctly.
>
> Technical details: The script was updated by futurize (
> https://python-future.org/futurize.html) to support Py2/Py3 syntax. The f=
ew
> references to classes in future were reworked so that future would not be
> required. The existing code test for Unicode support was extended to
> normalize the classes =E2=80=9Cunicode=E2=80=9D and =E2=80=9Cbytes=E2=80=
=9D to across platforms:
>
>  * =E2=80=98unicode=E2=80=99 is an alias for =E2=80=98str=E2=80=99 in Py3=
 and is the unicode class in Py2.
>  * =E2=80=98bytes=E2=80=99 is bytes in Py3 and an alias for =E2=80=98str=
=E2=80=99 in Py2.
>
> New coercion methods were written for both Python2 and Python3:
>
>  * as_string(text) =E2=80=93 In Python3, this encodes a bytes object as a=
 UTF-8
>    encoded Unicode string.
>  * as_bytes(text) =E2=80=93 In Python3, this decodes a Unicode string to =
an array of
>    bytes.
>
> In Python2, these functions do not change the data since a =E2=80=98str=
=E2=80=99 object
> function in both roles as strings and byte arrays. This reduces the
> potential impact on backward compatibility with Python 2.
>
>  * to_unicode(text) =E2=80=93 ensures that the supplied data is encoded a=
s a UTF-8
>    string. This function will encode data in both Python2 and Python3. *
>       path_as_string(path) =E2=80=93 This function is an extension functi=
on that
>       honors the option =E2=80=9Cgit-p4.pathEncoding=E2=80=9D to convert =
a set of bytes or
>       characters to UTF-8. If the str/bytes cannot decode as ASCII, it wi=
ll
>       use the encodeWithUTF8() method to convert the custom encoded bytes=
 to
>       Unicode in UTF-8.
>
>
>
> Generally speaking, information in the script is converted to Unicode as
> early as possible and converted back to a byte array just before passing =
to
> external programs or files. The exception to this rule is P4 Repository f=
ile
> paths.
>
> Paths are not converted but left as =E2=80=9Cbytes=E2=80=9D so the origin=
al file path
> encoding can be preserved. This formatting is required for commands that
> interact with the P4 file path. When the file path is used by GIT, it is
> converted with encodeWithUTF8().
>

Almost all the tests pass now - nice!

(There's one test that fails for me, t9830-git-p4-symlink-dir.sh).

Nitpicking:

- There are some bits of trailing whitespace around - can you strip
those out? You can use "git diff --check".
- Also I think the convention for git commits is that they be limited
to 72 (?) characters.
- In 10dc commit message, s/behvior/behavior
- Maybe submit 4fc4 as a separate patch series? It doesn't seem
directly related to your python3 changes.
- s/howerver/however/

The comment at line 3261 (showing the fast-import syntax) has wonky
indentation, and needs a space after the '#'.

This code looked like we're duplicating stuff:

+    if isinstance(path, unicode):
+        path =3D path.replace("%", "%25") \
+                   .replace("*", "%2A") \
+                   .replace("#", "%23") \
+                   .replace("@", "%40")
+    else:
+        path =3D path.replace(b"%", b"%25") \
+                   .replace(b"*", b"%2A") \
+                   .replace(b"#", b"%23") \
+                   .replace(b"@", b"%40")

I wonder if we can have a helper to do this?

In patchRCSKeywords() you've added code to cleanup outFile. But I
wonder if we could just use a 'finally' block, or a contextexpr ("with
blah as outFile:")

I don't know if it's worth doing now that you've got it going, but at
one point I tried simplifying code like this:

   path_as_string(file['depotFile'])
and
   marshalled[b'data']

by using a dictionary with overloaded operators which would do the
bytes/string conversion automatically. However, your approach isn't
actually _that_ invasive, so maybe this is not necessary.

Looks good though, thanks!
Luke






> Signed-off-by: Ben Keene seraphire@gmail.com [seraphire@gmail.com]
>
> Ben Keene (11):
>   git-p4: select p4 binary by operating-system
>   git-p4: change the expansion test from basestring to list
>   git-p4: add new helper functions for python3 conversion
>   git-p4: python3 syntax changes
>   git-p4: Add new functions in preparation of usage
>   git-p4: Fix assumed path separators to be more Windows friendly
>   git-p4: Add a helper class for stream writing
>   git-p4: p4CmdList  - support Unicode encoding
>   git-p4: Add usability enhancements
>   git-p4: Support python3 for basic P4 clone, sync, and submit
>   git-p4: Added --encoding parameter to p4 clone
>
>  Documentation/git-p4.txt        |   5 +
>  git-p4.py                       | 690 ++++++++++++++++++++++++--------
>  t/t9822-git-p4-path-encoding.sh | 101 +++++
>  3 files changed, 629 insertions(+), 167 deletions(-)
>
>
> base-commit: 228f53135a4a41a37b6be8e4d6e2b6153db4a8ed
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-463%2Fs=
eraphire%2Fseraphire%2Fp4-python3-unicode-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-463/seraph=
ire/seraphire/p4-python3-unicode-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/463
>
> Range-diff vs v3:
>
>   -:  ---------- >  1:  4012426993 git-p4: select p4 binary by operating-=
system
>   -:  ---------- >  2:  0ef2f56b04 git-p4: change the expansion test from=
 basestring to list
>   -:  ---------- >  3:  f0e658b984 git-p4: add new helper functions for p=
ython3 conversion
>   -:  ---------- >  4:  3c41db3e91 git-p4: python3 syntax changes
>   -:  ---------- >  5:  1bf7b073b0 git-p4: Add new functions in preparati=
on of usage
>   -:  ---------- >  6:  8f5752c127 git-p4: Fix assumed path separators to=
 be more Windows friendly
>   -:  ---------- >  7:  10dc059444 git-p4: Add a helper class for stream =
writing
>   -:  ---------- >  8:  e1a424a955 git-p4: p4CmdList  - support Unicode e=
ncoding
>   -:  ---------- >  9:  4fc49313f0 git-p4: Add usability enhancements
>   1:  02b3843e9f ! 10:  04a0aedbaa Python3 support for t9800 tests. Basic=
 P4/Python3 support
>      @@ -1,159 +1,60 @@
>       Author: Ben Keene <seraphire@gmail.com>
>
>      -    Python3 support for t9800 tests. Basic P4/Python3 support
>      +    git-p4: Support python3 for basic P4 clone, sync, and submit
>      +
>      +    Issue: Python 3 is still not properly supported for any use wit=
h the git-p4 python code.
>      +    Warning - this is a very large atomic commit.  The commit text =
is also very large.
>      +
>      +    Change the code such that, with the exception of P4 depot paths=
 and depot files, all text read by git-p4 is cast as a string as soon as po=
ssible and converted back to bytes as late as possible, following Python2 t=
o Python3 conversion best practices.
>      +
>      +    Important: Do not cast the bytes that contain the p4 depot path=
 or p4 depot file name.  These should be left as bytes until used.
>      +
>      +    These two values should not be converted because the encoding o=
f these values is unknown.  git-p4 supports a configuration value git-p4.pa=
thEncoding that is used by the encodeWithUTF8()  to determine what a UTF8 v=
ersion of the path and filename should be.  However, since depot path and d=
epot filename need to be sent to P4 in their original encoding, they will b=
e left as byte streams until they are actually used:
>      +
>      +    * When sent to P4, the bytes are literally passed to the p4 com=
mand
>      +    * When displayed in text for the user, they should be passed th=
rough the path_as_string() function
>      +    * When used by GIT they should be passed through the encodeWith=
UTF8() function
>      +
>      +    Change all the rest of system calls to cast output (stdin) as_b=
ytes() and input (stdout) as_string().  This retains existing Python 2 supp=
ort, and adds python 3 support for these functions:
>      +    * read_pipe_full
>      +    * read_pipe_lines
>      +    * p4_has_move_command (used internally)
>      +    * gitConfig
>      +    * branch_exists
>      +    * GitLFS.generatePointer
>      +    * applyCommit - template must be read and written to the tempor=
ary file as_bytes() since it is created in memory as a string.
>      +    * streamOneP4File(file, contents) - wrap calls to the depotFile=
 in path_as_string() for display. The file contents must be retained as byt=
es, so update the RCS changes to be forced to bytes.
>      +    * streamP4Files
>      +    * importHeadRevision(revision) - encode the depotPaths for disp=
lay separate from the text for processing.
>      +
>      +    Py23File usage -
>      +    Change the P4Sync.OpenStreams() function to cast the gitOutput,=
 gitStream, and gitError streams as Py23File() wrapper classes.  This facil=
itates taking strings in both python 2 and python 3 and casting them to byt=
es in the wrapper class instead of having to modify each method. Since the =
fast-import command also expects a raw byte stream for file content, add a =
new stream handle - gitStreamBytes which is an unwrapped verison of gitStre=
am.
>      +
>      +    Literal text -
>      +    Depending on context, most literal text does not need casting t=
o unicode or bytes as the text is Python dependent - In python 2, the strin=
g is implied as 'str' and python 3 the string is implied as 'unicode'. Unde=
r these conditions, they match the rest of the operating text, following be=
st practices.  However, when a literal string is used in functions that are=
 dealing with the raw input from and raw ouput to files streams, literal by=
tes may be required. Additionally, functions that are dealing with P4 depot=
 paths or P4 depot file names are also dealing with bytes and will require =
the same casting as bytes.  The following functions cast text as byte strin=
gs:
>      +    * wildcard_decode(path) - the path parameter is a P4 depot and =
is bytes. Cast all the literals to bytes.
>      +    * wildcard_encode(path) - the path parameter is a P4 depot and =
is bytes. Cast all the literals to bytes.
>      +    * streamP4FilesCb(marshalled) - the marshalled data is in bytes=
. Cast the literals as bytes. When using this data to manipulate self.strea=
m_file, encode all the marshalled data except for the 'depotFile' name.
>      +    * streamP4Files
>      +
>      +    Special behavior:
>      +    * p4_describe - encoding is disabled for the depotFile(x) and p=
ath elements since these are depot path and depo filenames.
>      +    * p4PathStartsWith(path, prefix) - Since P4 depot paths can con=
tain non-UTF-8 encoded strings, change this method to compare paths while s=
upporting the optional encoding.
>      +       - First, perform a byte-to-byte check to see if the path and=
 prefix are both identical text.  There is no need to perform encoding conv=
ersions if the text is identical.
>      +       - If the byte check fails, pass both the path and prefix thr=
ough encodeWithUTF8() to ensure both paths are using the same encoding. The=
n perform the test as originally written.
>      +    * patchRCSKeywords(file, pattern) - the parameters of file and =
pattern are both strings. However this function changes the contents of the=
 file itentified by name "file". Treat the content of this file as binary t=
o ensure that python does not accidently change the original encoding. The =
regular expression is cast as_bytes() and run against the file as_bytes(). =
The P4 keywords are ASCII strings and cannot span lines so iterating over e=
ach line of the file is acceptable.
>      +    * writeToGitStream(gitMode, relPath, contents) - Since 'content=
s' is already bytes data, instead of using the self.gitStream, use the new =
self.gitStreamBytes - the unwrapped gitStream that does not cast as_bytes()=
 the binary data.
>      +    * commit(details, files, branch, parent =3D "", allow_empty=3DF=
alse) - Changed the encoding for the commit message to the preferred format=
 for fast-import. The number of bytes is sent in the data block instead of =
using the EOT marker.
>      +    * Change the code for handling the user cache to use binary fil=
es. Cast text as_bytes() when writing to the cache and as_string() when rea=
ding from the cache.  This makes the reading and writing of the cache deter=
minstic in it's encoding. Unlike file paths, P4 encodes the user names in U=
TF-8 encoding so no additional string encoding is required.
>
>           Signed-off-by: Ben Keene <seraphire@gmail.com>
>      +    (cherry picked from commit 65ff0c74ebe62a200b4385ecfd4aa618ce09=
1f48)
>
>        diff --git a/git-p4.py b/git-p4.py
>        --- a/git-p4.py
>        +++ b/git-p4.py
>       @@
>      - import zlib
>      - import ctypes
>      - import errno
>      -+import os.path
>      -+import codecs
>      -+import io
>      -
>      - # support basestring in python3
>      - try:
>      -     unicode =3D unicode
>      - except NameError:
>      -     # 'unicode' is undefined, must be Python 3
>      --    str =3D str
>      -+    #
>      -+    # For Python3 which is natively unicode, we will use
>      -+    # unicode for internal information but all P4 Data
>      -+    # will remain in bytes
>      -+    isunicode =3D True
>      -     unicode =3D str
>      -     bytes =3D bytes
>      --    basestring =3D (str,bytes)
>      -+
>      -+    def as_string(text):
>      -+        """Return a byte array as a unicode string"""
>      -+        if text =3D=3D None:
>      -+            return None
>      -+        if isinstance(text, bytes):
>      -+            return unicode(text, "utf-8")
>      -+        else:
>      -+            return text
>      -+
>      -+    def as_bytes(text):
>      -+        """Return a Unicode string as a byte array"""
>      -+        if text =3D=3D None:
>      -+            return None
>      -+        if isinstance(text, bytes):
>      -+            return text
>      -+        else:
>      -+            return bytes(text, "utf-8")
>      -+
>      -+    def to_unicode(text):
>      -+        """Return a byte array as a unicode string"""
>      -+        return as_string(text)
>      -+
>      -+    def path_as_string(path):
>      -+        """ Converts a path to the UTF8 encoded string """
>      -+        if isinstance(path, unicode):
>      -+            return path
>      -+        return encodeWithUTF8(path).decode('utf-8')
>      -+
>      - else:
>      -     # 'unicode' exists, must be Python 2
>      --    str =3D str
>      -+    #
>      -+    # We will treat the data as:
>      -+    #   str   -> str
>      -+    #   bytes -> str
>      -+    # So for Python2 these functions are no-ops
>      -+    # and will leave the data in the ambiguious
>      -+    # string/bytes state
>      -+    isunicode =3D False
>      -     unicode =3D unicode
>      -     bytes =3D str
>      --    basestring =3D basestring
>      -+
>      -+    def as_string(text):
>      -+        """ Return text unaltered (for Python3 support) """
>      -+        return text
>      -+
>      -+    def as_bytes(text):
>      -+        """ Return text unaltered (for Python3 support) """
>      -+        return text
>      -+
>      -+    def to_unicode(text):
>      -+        """Return a string as a unicode string"""
>      -+        return text.decode('utf-8')
>      -+
>      -+    def path_as_string(path):
>      -+        """ Converts a path to the UTF8 encoded bytes """
>      -+        return encodeWithUTF8(path)
>      -+
>      -+
>      -+
>      -+# Check for raw_input support
>      -+try:
>      -+    raw_input
>      -+except NameError:
>      -+    raw_input =3D input
>      -
>      - try:
>      -     from subprocess import CalledProcessError
>      -@@
>      -     location. It means that hooking into the environment, or other=
 configuration
>      -     can be done more easily.
>      -     """
>      --    real_cmd =3D ["p4"]
>      -+    # Look for the P4 binary
>      -+    if (platform.system() =3D=3D "Windows"):
>      -+        real_cmd =3D ["p4.exe"]
>      -+    else:
>      -+        real_cmd =3D ["p4"]
>      -
>      -     user =3D gitConfig("git-p4.user")
>      -     if len(user) > 0:
>      -@@
>      -         # Provide a way to not pass this option by setting git-p4.=
retries to 0
>      -         real_cmd +=3D ["-r", str(retries)]
>      -
>      --    if isinstance(cmd,basestring):
>      -+    if not isinstance(cmd, list):
>      -         real_cmd =3D ' '.join(real_cmd) + ' ' + cmd
>      -     else:
>      -         real_cmd +=3D cmd
>      -@@
>      -         sys.exit(1)
>      -
>      - def write_pipe(c, stdin):
>      -+    """Executes the command 'c', passing 'stdin' on the standard i=
nput"""
>      -     if verbose:
>      -         sys.stderr.write('Writing pipe: %s\n' % str(c))
>      -
>      --    expand =3D isinstance(c,basestring)
>      -+    expand =3D not isinstance(c, list)
>      -     p =3D subprocess.Popen(c, stdin=3Dsubprocess.PIPE, shell=3Dexp=
and)
>      -     pipe =3D p.stdin
>      -     val =3D pipe.write(stdin)
>      -@@
>      -     if p.wait():
>      -         die('Command failed: %s' % str(c))
>      -
>      --    return val
>      -
>      - def p4_write_pipe(c, stdin):
>      -+    """ Runs a P4 command 'c', passing 'stdin' data to P4"""
>      -     real_cmd =3D p4_build_cmd(c)
>      --    return write_pipe(real_cmd, stdin)
>      -+    write_pipe(real_cmd, stdin)
>      -
>      - def read_pipe_full(c):
>      -     """ Read output from  command. Returns a tuple
>      -@@
>      -     if verbose:
>      -         sys.stderr.write('Reading pipe: %s\n' % str(c))
>      -
>      --    expand =3D isinstance(c,basestring)
>      -+    expand =3D not isinstance(c, list)
>      +     expand =3D not isinstance(c, list)
>            p =3D subprocess.Popen(c, stdout=3Dsubprocess.PIPE, stderr=3Ds=
ubprocess.PIPE, shell=3Dexpand)
>            (out, err) =3D p.communicate()
>       +    out =3D as_string(out)
>      @@ -179,10 +80,7 @@
>            if verbose:
>                sys.stderr.write('Reading pipe: %s\n' % str(c))
>
>      --    expand =3D isinstance(c, basestring)
>      -+    expand =3D not isinstance(c, list)
>      -     p =3D subprocess.Popen(c, stdout=3Dsubprocess.PIPE, shell=3Dex=
pand)
>      -     pipe =3D p.stdout
>      +@@
>            val =3D pipe.readlines()
>            if pipe.close() or p.wait():
>                die('Command failed: %s' % str(c))
>      @@ -203,28 +101,6 @@
>            # return code will be 1 in either case
>            if err.find("Invalid option") >=3D 0:
>                return False
>      -@@
>      -     return True
>      -
>      - def system(cmd, ignore_error=3DFalse):
>      --    expand =3D isinstance(cmd,basestring)
>      -+    expand =3D not isinstance(cmd, list)
>      -     if verbose:
>      -         sys.stderr.write("executing %s\n" % str(cmd))
>      -     retcode =3D subprocess.call(cmd, shell=3Dexpand)
>      -@@
>      -     return retcode
>      -
>      - def p4_system(cmd):
>      --    """Specifically invoke p4 as the system command. """
>      -+    """ Specifically invoke p4 as the system command.
>      -+    """
>      -     real_cmd =3D p4_build_cmd(cmd)
>      --    expand =3D isinstance(real_cmd, basestring)
>      -+    expand =3D not isinstance(real_cmd, list)
>      -     retcode =3D subprocess.call(real_cmd, shell=3Dexpand)
>      -     if retcode:
>      -         raise CalledProcessError(retcode, real_cmd)
>       @@
>            return int(results[0]['change'])
>
>      @@ -234,7 +110,7 @@
>       -       results."""
>       +    """ Returns information about the requested P4 change list.
>       +
>      -+        Data returns is not string encoded (returned as bytes)
>      ++        Data returned is not string encoded (returned as bytes)
>       +    """
>       +    # Make sure it returns a valid result by checking for
>       +    #   the presence of field "time".  Return a dict of the
>      @@ -261,218 +137,29 @@
>            if "time" not in d:
>                die("p4 describe -s %d returned no \"time\": %s" % (change=
, str(d)))
>
>      -+    # Convert depotFile(X) to be UTF-8 encoded, as this is what GI=
T
>      -+    # requires. This will also allow us to encode the rest of the =
text
>      -+    # at the same time to simplify textual processing later.
>      ++    # Do not convert 'depotFile(X)' or 'path' to be UTF-8 encoded,=
 however
>      ++    # cast as_string() the rest of the text.
>       +    keys=3Dd.keys()
>       +    for key in keys:
>       +        if key.startswith('depotFile'):
>      -+            d[key]=3Dd[key] #DepotPath(d[key])
>      ++            d[key]=3Dd[key]
>       +        elif key =3D=3D 'path':
>      -+            d[key]=3Dd[key] #DepotPath(d[key])
>      ++            d[key]=3Dd[key]
>       +        else:
>       +            d[key] =3D as_string(d[key])
>       +
>            return d
>
>      --#
>      --# Canonicalize the p4 type and return a tuple of the
>      --# base type, plus any modifiers.  See "p4 help filetypes"
>      --# for a list and explanation.
>      --#
>      - def split_p4_type(p4type):
>      --
>      -+    """ Canonicalize the p4 type and return a tuple of the
>      -+        base type, plus any modifiers.  See "p4 help filetypes"
>      -+        for a list and explanation.
>      -+    """
>      -     p4_filetypes_historical =3D {
>      -         "ctempobj": "binary+Sw",
>      -         "ctext": "text+C",
>      -@@
>      -         mods =3D s[1]
>      -     return (base, mods)
>      -
>      --#
>      --# return the raw p4 type of a file (text, text+ko, etc)
>      --#
>      - def p4_type(f):
>      -+    """ return the raw p4 type of a file (text, text+ko, etc)
>      -+    """
>      -     results =3D p4CmdList(["fstat", "-T", "headType", wildcard_enc=
ode(f)])
>      -     return results[0]['headType']
>      -
>      --#
>      --# Given a type base and modifier, return a regexp matching
>      --# the keywords that can be expanded in the file
>      --#
>      - def p4_keywords_regexp_for_type(base, type_mods):
>      -+    """ Given a type base and modifier, return a regexp matching
>      -+        the keywords that can be expanded in the file
>      -+    """
>      -     if base in ("text", "unicode", "binary"):
>      -         kwords =3D None
>      -         if "ko" in type_mods:
>      -@@
>      -     else:
>      -         return None
>      -
>      --#
>      --# Given a file, return a regexp matching the possible
>      --# RCS keywords that will be expanded, or None for files
>      --# with kw expansion turned off.
>      --#
>      - def p4_keywords_regexp_for_file(file):
>      -+    """ Given a file, return a regexp matching the possible
>      -+        RCS keywords that will be expanded, or None for files
>      -+        with kw expansion turned off.
>      -+    """
>      -     if not os.path.exists(file):
>      -         return None
>      -     else:
>      -@@
>      - # Return the set of all p4 labels
>      - def getP4Labels(depotPaths):
>      -     labels =3D set()
>      --    if isinstance(depotPaths,basestring):
>      -+    if not isinstance(depotPaths, list):
>      -         depotPaths =3D [depotPaths]
>      -
>      -     for l in p4CmdList(["labels"] + ["%s..." % p for p in depotPat=
hs]):
>      -@@
>      -
>      -     return labels
>      -
>      --# Return the set of all git tags
>      - def getGitTags():
>      -+    """Return the set of all git tags"""
>      -     gitTags =3D set()
>      -     for line in read_pipe_lines(["git", "tag"]):
>      -         tag =3D line.strip()
>      -@@
>      -
>      -     If the pattern is not matched, None is returned."""
>      -
>      --    match =3D diffTreePattern().next().match(entry)
>      -+    match =3D next(diffTreePattern()).match(entry)
>      -     if match:
>      -         return {
>      -             'src_mode': match.group(1),
>      -@@
>      -     # otherwise False.
>      -     return mode[-3:] =3D=3D "755"
>      -
>      -+def encodeWithUTF8(path, verbose =3D False):
>      -+    """ Ensure that the path is encoded as a UTF-8 string
>      -+
>      -+        Returns bytes(P3)/str(P2)
>      -+    """
>      -+
>      -+    if isunicode:
>      -+        try:
>      -+            if isinstance(path, unicode):
>      -+                # It is already unicode, cast it as a bytes
>      -+                # that is encoded as utf-8.
>      -+                return path.encode('utf-8', 'strict')
>      -+            path.decode('ascii', 'strict')
>      -+        except:
>      -+            encoding =3D 'utf8'
>      -+            if gitConfig('git-p4.pathEncoding'):
>      -+                encoding =3D gitConfig('git-p4.pathEncoding')
>      -+            path =3D path.decode(encoding, 'replace').encode('utf8=
', 'replace')
>      -+            if verbose:
>      -+                print('\nNOTE:Path with non-ASCII characters detec=
ted. Used %s to encode: %s ' % (encoding, to_unicode(path)))
>      -+    else:
>      -+        try:
>      -+            path.decode('ascii')
>      -+        except:
>      -+            encoding =3D 'utf8'
>      -+            if gitConfig('git-p4.pathEncoding'):
>      -+                encoding =3D gitConfig('git-p4.pathEncoding')
>      -+            path =3D path.decode(encoding, 'replace').encode('utf8=
', 'replace')
>      -+            if verbose:
>      -+                print('Path with non-ASCII characters detected. Us=
ed %s to encode: %s ' % (encoding, path))
>      -+    return path
>      -+
>      - class P4Exception(Exception):
>      -     """ Base class for exceptions from the p4 client """
>      -     def __init__(self, exit_code):
>      -@@
>      -     return isModeExec(src_mode) !=3D isModeExec(dst_mode)
>      -
>      - def p4CmdList(cmd, stdin=3DNone, stdin_mode=3D'w+b', cb=3DNone, sk=
ip_info=3DFalse,
>      --        errors_as_exceptions=3DFalse):
>      -+        errors_as_exceptions=3DFalse, encode_data=3DTrue):
>      -+    """ Executes a P4 command:  'cmd' optionally passing 'stdin' t=
o the command's
>      -+        standard input via a temporary file with 'stdin_mode' mode=
.
>      -+
>      -+        Output from the command is optionally passed to the callba=
ck function 'cb'.
>      -+        If 'cb' is None, the response from the command is parsed i=
nto a list
>      -+        of resulting dictionaries. (For each block read from the p=
rocess pipe.)
>      -+
>      -+        If 'skip_info' is true, information in a block read that h=
as a code type of
>      -+        'info' will be skipped.
>      -
>      --    if isinstance(cmd,basestring):
>      -+        If 'errors_as_exceptions' is set to true (the default is f=
alse) the error
>      -+        code returned from the execution will generate an exceptio=
n.
>      -+
>      -+        If 'encode_data' is set to true (the default) the data tha=
t is returned
>      -+        by this function will be passed through the "as_string" fu=
nction.
>      -+    """
>      -+
>      -+    if not isinstance(cmd, list):
>      -         cmd =3D "-G " + cmd
>      -         expand =3D True
>      -     else:
>      -@@
>      -     stdin_file =3D None
>      -     if stdin is not None:
>      -         stdin_file =3D tempfile.TemporaryFile(prefix=3D'p4-stdin',=
 mode=3Dstdin_mode)
>      --        if isinstance(stdin,basestring):
>      -+        if not isinstance(stdin, list):
>      -             stdin_file.write(stdin)
>      -         else:
>      -             for i in stdin:
>      --                stdin_file.write(i + '\n')
>      -+                stdin_file.write(as_bytes(i) + b'\n')
>      -         stdin_file.flush()
>      -         stdin_file.seek(0)
>      -
>      -@@
>      -         while True:
>      -             entry =3D marshal.load(p4.stdout)
>      -             if skip_info:
>      --                if 'code' in entry and entry['code'] =3D=3D 'info'=
:
>      -+                if b'code' in entry and entry[b'code'] =3D=3D b'in=
fo':
>      -                     continue
>      -             if cb is not None:
>      -                 cb(entry)
>      -             else:
>      --                result.append(entry)
>      -+                out =3D {}
>      -+                for key, value in entry.items():
>      -+                    out[as_string(key)] =3D (as_string(value) if e=
ncode_data else value)
>      -+                result.append(out)
>      -     except EOFError:
>      -         pass
>      -     exitCode =3D p4.wait()
>      + #
>       @@
>            return result
>
>        def p4Cmd(cmd):
>      -+    """ Executes a P4 command an returns the results in a dictiona=
ry"""
>      ++    """ Executes a P4 command and returns the results in a diction=
ary
>      ++    """
>            list =3D p4CmdList(cmd)
>            result =3D {}
>            for entry in list:
>      -@@
>      -     return values
>      -
>      - def gitBranchExists(branch):
>      -+    """Checks to see if a given branch exists in the git repo"""
>      -     proc =3D subprocess.Popen(["git", "rev-parse", branch],
>      -                             stderr=3Dsubprocess.PIPE, stdout=3Dsub=
process.PIPE);
>      -     return proc.wait() =3D=3D 0;
>       @@
>        _gitConfig =3D {}
>
>      @@ -490,29 +177,6 @@
>            return _gitConfig[key]
>
>        def gitConfigBool(key):
>      --    """Return a bool, using git config --bool.  It is True only if=
 the
>      --       variable is set to true, and False if set to false or not p=
resent
>      --       in the config."""
>      --
>      -+    """ Return a bool, using git config --bool.  It is True only i=
f the
>      -+        variable is set to true, and False if set to false or not =
present
>      -+        in the config.
>      -+    """
>      -     if key not in _gitConfig:
>      -         _gitConfig[key] =3D gitConfig(key, '--bool') =3D=3D "true"
>      -     return _gitConfig[key]
>      -@@
>      -             _gitConfig[key] =3D []
>      -     return _gitConfig[key]
>      -
>      -+def gitConfigSet(key, value):
>      -+    """ Set the git configuration key 'key' to 'value' for this se=
ssion
>      -+    """
>      -+    _gitConfig[key] =3D value
>      -+
>      - def p4BranchesInGit(branchesAreInRemotes=3DTrue):
>      -     """Find all the branches whose names start with "p4/", looking
>      -        in remotes or heads as specified by the argument.  Return
>       @@
>            cmd =3D [ "git", "rev-parse", "--symbolic", "--verify", branch=
 ]
>            p =3D subprocess.Popen(cmd, stdout=3Dsubprocess.PIPE, stderr=
=3Dsubprocess.PIPE)
>      @@ -521,34 +185,6 @@
>            if p.returncode:
>                return False
>            # expect exactly one line of output: the branch name
>      -@@
>      -     branches =3D p4BranchesInGit()
>      -     # map from depot-path to branch name
>      -     branchByDepotPath =3D {}
>      --    for branch in branches.keys():
>      -+    for branch in list(branches.keys()):
>      -         tip =3D branches[branch]
>      -         log =3D extractLogMessageFromGitCommit(tip)
>      -         settings =3D extractSettingsGitLog(log)
>      -@@
>      -             system("git update-ref %s %s" % (remoteHead, originHea=
d))
>      -
>      - def originP4BranchesExist():
>      --        return gitBranchExists("origin") or gitBranchExists("origi=
n/p4") or gitBranchExists("origin/p4/master")
>      -+    """Checks if origin/p4/master exists"""
>      -+    return gitBranchExists("origin") or gitBranchExists("origin/p4=
") or gitBranchExists("origin/p4/master")
>      -
>      -
>      - def p4ParseNumericChangeRange(parts):
>      -@@
>      -     changes =3D sorted(changes)
>      -     return changes
>      -
>      --def p4PathStartsWith(path, prefix):
>      -+def p4PathStartsWith(path, prefix, verbose =3D False):
>      -     # This method tries to remedy a potential mixed-case issue:
>      -     #
>      -     # If UserA adds  //depot/DirA/file1
>       @@
>            #
>            # we may or may not have a problem. If you have core.ignorecas=
e=3Dtrue,
>      @@ -574,15 +210,6 @@
>
>        def getClientSpec():
>            """Look at the p4 client spec, create a View() object that con=
tains
>      -@@
>      -     client_name =3D entry["Client"]
>      -
>      -     # just the keys that start with "View"
>      --    view_keys =3D [ k for k in entry.keys() if k.startswith("View"=
) ]
>      -+    view_keys =3D [ k for k in list(entry.keys()) if k.startswith(=
"View") ]
>      -
>      -     # hold this new View
>      -     view =3D View(client_name)
>       @@
>            # Cannot have * in a filename in windows; untested as to
>            # what p4 would do in such a case.
>      @@ -626,45 +253,16 @@
>                    os.remove(contentFile)
>                    die('git-lfs pointer command failed. Did you install t=
he extension?')
>       @@
>      -         else:
>      -             return LargeFileSystem.processContent(self, git_mode, =
relPath, contents)
>      -
>      --class Command:
>      -+class Command(object):
>      -     delete_actions =3D ( "delete", "move/delete", "purge" )
>      -     add_actions =3D ( "add", "branch", "move/add" )
>      -
>      -@@
>      -             setattr(self, attr, value)
>      -         return getattr(self, attr)
>      -
>      --class P4UserMap:
>      -+class P4UserMap(object):
>      -     def __init__(self):
>      -         self.userMapFromPerforceServer =3D False
>      -         self.myP4UserId =3D None
>      -@@
>      -             return True
>      -
>      -     def getUserCacheFilename(self):
>      -+        """ Returns the filename of the username cache """
>      -         home =3D os.environ.get("HOME", os.environ.get("USERPROFIL=
E"))
>      --        return home + "/.gitp4-usercache.txt"
>      -+        return os.path.join(home, ".gitp4-usercache.txt")
>      +         return os.path.join(home, ".gitp4-usercache.txt")
>
>            def getUserMapFromPerforceServer(self):
>       +        """ Creates the usercache from the data in P4.
>       +        """
>      -+
>                if self.userMapFromPerforceServer:
>                    return
>                self.users =3D {}
>       @@
>      -                 self.emails[email] =3D user
>      -
>      -         s =3D ''
>      --        for (key, val) in self.users.items():
>      -+        for (key, val) in list(self.users.items()):
>      +         for (key, val) in list(self.users.items()):
>                    s +=3D "%s\t%s\n" % (key.expandtabs(1), val.expandtabs=
(1))
>
>       -        open(self.getUserCacheFilename(), "wb").write(s)
>      @@ -674,7 +272,8 @@
>                self.userMapFromPerforceServer =3D True
>
>            def loadUserMapFromCache(self):
>      -+        """ Reads the P4 username to git email map """
>      ++        """ Reads the P4 username to git email map
>      ++        """
>                self.users =3D {}
>                self.userMapFromPerforceServer =3D False
>                try:
>      @@ -721,80 +320,6 @@
>                    # cleanup our temporary file
>                    os.unlink(outFileName)
>                    print("Failed to strip RCS keywords in %s" % file)
>      -@@
>      -                 break
>      -         if not change_entry:
>      -             die('Failed to decode output of p4 change -o')
>      --        for key, value in change_entry.iteritems():
>      -+        for key, value in list(change_entry.items()):
>      -             if key.startswith('File'):
>      -                 if 'depot-paths' in settings:
>      -                     if not [p for p in settings['depot-paths']
>      --                            if p4PathStartsWith(value, p)]:
>      -+                            if p4PathStartsWith(value, p, self.ver=
bose)]:
>      -                         continue
>      -                 else:
>      --                    if not p4PathStartsWith(value, self.depotPath)=
:
>      -+                    if not p4PathStartsWith(value, self.depotPath,=
 self.verbose):
>      -                         continue
>      -                 files_list.append(value)
>      -                 continue
>      -@@
>      -             return True
>      -
>      -         while True:
>      --            response =3D raw_input("Submit template unchanged. Sub=
mit anyway? [y]es, [n]o (skip this patch) ")
>      -+            response =3D raw_input("Submit template unchanged. Sub=
mit anyway? [y]es, [n]o (skip this patch) ").lower() \
>      -+                .strip()[0]
>      -             if response =3D=3D 'y':
>      -                 return True
>      -             if response =3D=3D 'n':
>      -@@
>      -     def applyCommit(self, id):
>      -         """Apply one commit, return True if it succeeded."""
>      -
>      --        print("Applying", read_pipe(["git", "show", "-s",
>      --                                     "--format=3Dformat:%h %s", id=
]))
>      -+        print(("Applying", read_pipe(["git", "show", "-s",
>      -+                                     "--format=3Dformat:%h %s", id=
])))
>      -
>      -         (p4User, gitEmail) =3D self.p4UserForCommit(id)
>      -
>      -@@
>      -                     # disable the read-only bit on windows.
>      -                     if self.isWindows and file not in editedFiles:
>      -                         os.chmod(file, stat.S_IWRITE)
>      --                    self.patchRCSKeywords(file, kwfiles[file])
>      --                    fixed_rcs_keywords =3D True
>      -+
>      -+                    try:
>      -+                        self.patchRCSKeywords(file, kwfiles[file])
>      -+                        fixed_rcs_keywords =3D True
>      -+                    except:
>      -+                        # We are throwing an exception, undo all o=
pen edits
>      -+                        for f in editedFiles:
>      -+                            p4_revert(f)
>      -+                        raise
>      -+            else:
>      -+                # They do not have attemptRCSCleanup set, this mig=
ht be the fail point
>      -+                # Check to see if the file has RCS keywords and su=
ggest setting the property.
>      -+                for file in editedFiles | filesToDelete:
>      -+                    if p4_keywords_regexp_for_file(file) !=3D None=
:
>      -+                        print("At least one file in this commit ha=
s RCS Keywords that may be causing problems. ")
>      -+                        print("Consider:\ngit config git-p4.attemp=
tRCSCleanup true")
>      -+                        break
>      -
>      -             if fixed_rcs_keywords:
>      -                 print("Retrying the patch with RCS keywords cleane=
d up")
>      -@@
>      -             p4_delete(f)
>      -
>      -         # Set/clear executable bits
>      --        for f in filesToChangeExecBit.keys():
>      -+        for f in list(filesToChangeExecBit.keys()):
>      -             mode =3D filesToChangeExecBit[f]
>      -             setP4ExecBit(f, mode)
>      -
>       @@
>                tmpFile =3D os.fdopen(handle, "w+b")
>                if self.isWindows:
>      @@ -815,179 +340,6 @@
>
>                        if update_shelve:
>                            p4_write_pipe(['shelve', '-r', '-i'], submitTe=
mplate)
>      -@@
>      -                 if verbose:
>      -                     print("created p4 label for tag %s" % name)
>      -
>      -+    def run_hook(self, hook_name, args =3D []):
>      -+        """ Runs a hook if it is found.
>      -+
>      -+            Returns NONE if the hook does not exist
>      -+            Returns TRUE if the exit code is 0, FALSE for a non-ze=
ro exit code.
>      -+        """
>      -+        hook_file =3D self.find_hook(hook_name)
>      -+        if hook_file =3D=3D None:
>      -+            if self.verbose:
>      -+                print("Skipping hook: %s" % hook_name)
>      -+            return None
>      -+
>      -+        if self.verbose:
>      -+            print("hooks_path =3D %s " % hooks_path)
>      -+            print("hook_file =3D %s " % hook_file)
>      -+
>      -+        # Run the hook
>      -+        # TODO - allow non-list format
>      -+        cmd =3D [hook_file] + args
>      -+        return subprocess.call(cmd) =3D=3D 0
>      -+
>      -+    def find_hook(self, hook_name):
>      -+        """ Locates the hook file for the given operating system.
>      -+        """
>      -+        hooks_path =3D gitConfig("core.hooksPath")
>      -+        if len(hooks_path) <=3D 0:
>      -+            hooks_path =3D os.path.join(os.environ.get("GIT_DIR", =
".git"), "hooks")
>      -+
>      -+        # Look in the obvious place
>      -+        hook_file =3D os.path.join(hooks_path, hook_name)
>      -+        if os.path.isfile(hook_file) and os.access(hook_file, os.X=
_OK):
>      -+            return hook_file
>      -+
>      -+        # if we are windows, we will also allow them to have the h=
ooks have extensions
>      -+        if (platform.system() =3D=3D "Windows"):
>      -+            for ext in ['.exe', '.bat', 'ps1']:
>      -+                if os.path.isfile(hook_file + ext) and os.access(h=
ook_file + ext, os.X_OK):
>      -+                    return hook_file + ext
>      -+
>      -+        # We didn't find the file
>      -+        return None
>      -+
>      -+
>      -+
>      -     def run(self, args):
>      -         if len(args) =3D=3D 0:
>      -             self.master =3D currentGitBranch()
>      -@@
>      -             self.clientSpecDirs =3D getClientSpec()
>      -
>      -         # Check for the existence of P4 branches
>      --        branchesDetected =3D (len(p4BranchesInGit().keys()) > 1)
>      -+        branchesDetected =3D (len(list(p4BranchesInGit().keys())) =
> 1)
>      -
>      -         if self.useClientSpec and not branchesDetected:
>      -             # all files are relative to the client spec
>      -@@
>      -             sys.exit("number of commits (%d) must match number of =
shelved changelist (%d)" %
>      -                      (len(commits), num_shelves))
>      -
>      --        hooks_path =3D gitConfig("core.hooksPath")
>      --        if len(hooks_path) <=3D 0:
>      --            hooks_path =3D os.path.join(os.environ.get("GIT_DIR", =
".git"), "hooks")
>      --
>      --        hook_file =3D os.path.join(hooks_path, "p4-pre-submit")
>      --        if os.path.isfile(hook_file) and os.access(hook_file, os.X=
_OK) and subprocess.call([hook_file]) !=3D 0:
>      -+        rtn =3D self.run_hook("p4-pre-submit")
>      -+        if rtn =3D=3D False:
>      -             sys.exit(1)
>      -
>      -         #
>      -@@
>      -         last =3D len(commits) - 1
>      -         for i, commit in enumerate(commits):
>      -             if self.dry_run:
>      --                print(" ", read_pipe(["git", "show", "-s",
>      --                                      "--format=3Dformat:%h %s", c=
ommit]))
>      -+                print((" ", read_pipe(["git", "show", "-s",
>      -+                                      "--format=3Dformat:%h %s", c=
ommit])))
>      -                 ok =3D True
>      -             else:
>      -                 ok =3D self.applyCommit(commit)
>      -@@
>      -                         if self.conflict_behavior =3D=3D "ask":
>      -                             print("What do you want to do?")
>      -                             response =3D raw_input("[s]kip this co=
mmit but apply"
>      --                                                 " the rest, or [q=
]uit? ")
>      -+                                                 " the rest, or [q=
]uit? ").lower().strip()[0]
>      -                             if not response:
>      -                                 continue
>      -                         elif self.conflict_behavior =3D=3D "skip":
>      -@@
>      -                         star =3D "*"
>      -                     else:
>      -                         star =3D " "
>      --                    print(star, read_pipe(["git", "show", "-s",
>      --                                           "--format=3Dformat:%h %=
s",  c]))
>      -+                    print((star, read_pipe(["git", "show", "-s",
>      -+                                           "--format=3Dformat:%h %=
s",  c])))
>      -                 print("You will have to do 'git p4 sync' and rebas=
e.")
>      -
>      -         if gitConfigBool("git-p4.exportLabels"):
>      -@@
>      -     # ("-//depot/A/..." becomes "/depot/A/..." after option parsin=
g)
>      -     parser.values.cloneExclude +=3D ["/" + re.sub(r"\.\.\.$", "", =
value)]
>      -
>      -+
>      - class P4Sync(Command, P4UserMap):
>      -
>      -     def __init__(self):
>      -@@
>      -         self.knownBranches =3D {}
>      -         self.initialParents =3D {}
>      -
>      --        self.tz =3D "%+03d%02d" % (- time.timezone / 3600, ((- tim=
e.timezone % 3600) / 60))
>      -+        self.tz =3D "%+03d%02d" % (- time.timezone // 3600, ((- ti=
me.timezone % 3600) // 60))
>      -         self.labels =3D {}
>      -
>      -     # Force a checkpoint in fast-import and wait for it to finish
>      -@@
>      -     def isPathWanted(self, path):
>      -         for p in self.cloneExclude:
>      -             if p.endswith("/"):
>      --                if p4PathStartsWith(path, p):
>      -+                if p4PathStartsWith(path, p, self.verbose):
>      -                     return False
>      -             # "-//depot/file1" without a trailing "/" should only =
exclude "file1", but not "file111" or "file1_dir/file2"
>      -             elif path.lower() =3D=3D p.lower():
>      -                 return False
>      -         for p in self.depotPaths:
>      --            if p4PathStartsWith(path, p):
>      -+            if p4PathStartsWith(path, p, self.verbose):
>      -                 return True
>      -         return False
>      -
>      -     def extractFilesFromCommit(self, commit, shelved=3DFalse, shel=
ved_cl =3D 0):
>      -+        """ Generates the list of files to be added in this git co=
mmit.
>      -+
>      -+            commit     =3D Unicode[] - data read from the P4 commi=
t
>      -+            shelved    =3D Bool      - Is the P4 commit flagged as=
 being shelved.
>      -+            shelved_cl =3D Unicode   - Numeric string with the cha=
ngelist number.
>      -+        """
>      -         files =3D []
>      -         fnum =3D 0
>      -         while "depotFile%s" % fnum in commit:
>      -@@
>      -             path =3D self.clientSpecDirs.map_in_client(path)
>      -             if self.detectBranches:
>      -                 for b in self.knownBranches:
>      --                    if p4PathStartsWith(path, b + "/"):
>      -+                    if p4PathStartsWith(path, b + "/", self.verbos=
e):
>      -                         path =3D path[len(b)+1:]
>      -
>      -         elif self.keepRepoPath:
>      -@@
>      -             # //depot/; just look at first prefix as they all shou=
ld
>      -             # be in the same depot.
>      -             depot =3D re.sub("^(//[^/]+/).*", r'\1', prefixes[0])
>      --            if p4PathStartsWith(path, depot):
>      -+            if p4PathStartsWith(path, depot, self.verbose):
>      -                 path =3D path[len(depot):]
>      -
>      -         else:
>      -             for p in prefixes:
>      --                if p4PathStartsWith(path, p):
>      -+                if p4PathStartsWith(path, p, self.verbose):
>      -                     path =3D path[len(p):]
>      -                     break
>      -
>       @@
>                return path
>
>      @@ -1002,19 +354,6 @@
>
>                if self.clientSpecDirs:
>                    files =3D self.extractFilesFromCommit(commit)
>      -@@
>      -             else:
>      -                 relPath =3D self.stripRepoPath(path, self.depotPat=
hs)
>      -
>      --            for branch in self.knownBranches.keys():
>      -+            for branch in list(self.knownBranches.keys()):
>      -                 # add a trailing slash so that a commit into qt/4.=
2foo
>      -                 # doesn't end up in qt/4.2, e.g.
>      --                if p4PathStartsWith(relPath, branch + "/"):
>      -+                if p4PathStartsWith(relPath, branch + "/", self.ve=
rbose):
>      -                     if branch not in branches:
>      -                         branches[branch] =3D []
>      -                     branches[branch].append(file)
>       @@
>                return branches
>
>      @@ -1031,18 +370,6 @@
>       +            self.gitStreamBytes.write(d)
>                self.gitStream.write('\n')
>
>      --    def encodeWithUTF8(self, path):
>      --        try:
>      --            path.decode('ascii')
>      --        except:
>      --            encoding =3D 'utf8'
>      --            if gitConfig('git-p4.pathEncoding'):
>      --                encoding =3D gitConfig('git-p4.pathEncoding')
>      --            path =3D path.decode(encoding, 'replace').encode('utf8=
', 'replace')
>      --            if self.verbose:
>      --                print('Path with non-ASCII characters detected. Us=
ed %s to encode: %s ' % (encoding, path))
>      --        return path
>      --
>       -    # output one file from the P4 stream
>       -    # - helper for streamP4Files
>       -
>      @@ -1053,18 +380,13 @@
>       +            contents should be a bytes (bytes)
>       +        """
>                relPath =3D self.stripRepoPath(file['depotFile'], self.bra=
nchPrefixes)
>      --        relPath =3D self.encodeWithUTF8(relPath)
>      -+        relPath =3D encodeWithUTF8(relPath, self.verbose)
>      +         relPath =3D encodeWithUTF8(relPath, self.verbose)
>                if verbose:
>      -             if 'fileSize' in self.stream_file:
>      +@@
>                        size =3D int(self.stream_file['fileSize'])
>                    else:
>                        size =3D 0 # deleted files don't get a fileSize ap=
parently
>      --            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depo=
tFile'], relPath, size/1024/1024))
>      -+            #if isunicode:
>      -+            #    sys.stdout.write('\r%s --> %s (%i MB)\n' % (path_=
as_string(file['depotFile']), to_unicode(relPath), size//1024//1024))
>      -+            #else:
>      -+            #    sys.stdout.write('\r%s --> %s (%i MB)\n' % (path_=
as_string(file['depotFile']), relPath, size//1024//1024))
>      +-            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depo=
tFile'], relPath, size//1024//1024))
>       +            sys.stdout.write('\r%s --> %s (%i MB)\n' % (path_as_st=
ring(file['depotFile']), as_string(relPath), size//1024//1024))
>                    sys.stdout.flush()
>
>      @@ -1100,15 +422,6 @@
>
>                if self.largeFileSystem:
>       @@
>      -
>      -     def streamOneP4Deletion(self, file):
>      -         relPath =3D self.stripRepoPath(file['path'], self.branchPr=
efixes)
>      --        relPath =3D self.encodeWithUTF8(relPath)
>      -+        relPath =3D encodeWithUTF8(relPath, self.verbose)
>      -         if verbose:
>      -             sys.stdout.write("delete %s\n" % relPath)
>      -             sys.stdout.flush()
>      -@@
>                if self.largeFileSystem and self.largeFileSystem.isLargeFi=
le(relPath):
>                    self.largeFileSystem.removeLargeFile(relPath)
>
>      @@ -1133,13 +446,6 @@
>
>                if not err and 'fileSize' in self.stream_file:
>                    required_bytes =3D int((4 * int(self.stream_file["file=
Size"])) - calcDiskFree())
>      -             if required_bytes > 0:
>      -                 err =3D 'Not enough space left on %s! Free at leas=
t %i MB.' % (
>      --                    os.getcwd(), required_bytes/1024/1024
>      -+                    os.getcwd(), required_bytes//1024//1024
>      -                 )
>      -
>      -         if err:
>       @@
>                    # ignore errors, but make sure it exits first
>                    self.importProcess.wait()
>      @@ -1155,12 +461,10 @@
>                    self.streamOneP4File(self.stream_file, self.stream_con=
tents)
>                    self.stream_file =3D {}
>       @@
>      -
>                # pick up the new file information... for the
>                # 'data' field we need to append to our array
>      --        for k in marshalled.keys():
>      +         for k in list(marshalled.keys()):
>       -            if k =3D=3D 'data':
>      -+        for k in list(marshalled.keys()):
>       +            if k =3D=3D b'data':
>                        if 'streamContentSize' not in self.stream_file:
>                            self.stream_file['streamContentSize'] =3D 0
>      @@ -1178,12 +482,10 @@
>                if (verbose and
>                    'streamContentSize' in self.stream_file and
>       @@
>      -             'depotFile' in self.stream_file):
>                    size =3D int(self.stream_file["fileSize"])
>                    if size > 0:
>      --                progress =3D 100*self.stream_file['streamContentSi=
ze']/size
>      --                sys.stdout.write('\r%s %d%% (%i MB)' % (self.strea=
m_file['depotFile'], progress, int(size/1024/1024)))
>      -+                progress =3D 100.0*self.stream_file['streamContent=
Size']/size
>      +                 progress =3D 100.0*self.stream_file['streamContent=
Size']/size
>      +-                sys.stdout.write('\r%s %4.1f%% (%i MB)' % (self.st=
ream_file['depotFile'], progress, int(size//1024//1024)))
>       +                sys.stdout.write('\r%s %4.1f%% (%i MB)' % (path_as=
_string(self.stream_file['depotFile']), progress, int(size//1024//1024)))
>                        sys.stdout.flush()
>
>      @@ -1227,24 +529,6 @@
>
>                if verbose:
>       @@
>      -
>      -         gitStream.write("tagger %s\n" % tagger)
>      -
>      --        print("labelDetails=3D",labelDetails)
>      -+        print(("labelDetails=3D",labelDetails))
>      -         if 'Description' in labelDetails:
>      -             description =3D labelDetails['Description']
>      -         else:
>      -@@
>      -         if not self.branchPrefixes:
>      -             return True
>      -         hasPrefix =3D [p for p in self.branchPrefixes
>      --                        if p4PathStartsWith(path, p)]
>      -+                        if p4PathStartsWith(path, p, self.verbose)=
]
>      -         if not hasPrefix and self.verbose:
>      -             print('Ignoring file outside of prefix: {0}'.format(pa=
th))
>      -         return hasPrefix
>      -@@
>                        .format(details['change']))
>                    return
>
>      @@ -1307,58 +591,6 @@
>
>                if len(parent) > 0:
>                    if self.verbose:
>      -@@
>      -             self.labels[newestChange] =3D [output, revisions]
>      -
>      -         if self.verbose:
>      --            print("Label changes: %s" % self.labels.keys())
>      -+            print("Label changes: %s" % list(self.labels.keys()))
>      -
>      -     # Import p4 labels as git tags. A direct mapping does not
>      -     # exist, so assume that if all the files are at the same revis=
ion
>      -@@
>      -                 source =3D paths[0]
>      -                 destination =3D paths[1]
>      -                 ## HACK
>      --                if p4PathStartsWith(source, self.depotPaths[0]) an=
d p4PathStartsWith(destination, self.depotPaths[0]):
>      -+                if p4PathStartsWith(source, self.depotPaths[0], se=
lf.verbose) and p4PathStartsWith(destination, self.depotPaths[0], self.verb=
ose):
>      -                     source =3D source[len(self.depotPaths[0]):-4]
>      -                     destination =3D destination[len(self.depotPath=
s[0]):-4]
>      -
>      -@@
>      -
>      -     def getBranchMappingFromGitBranches(self):
>      -         branches =3D p4BranchesInGit(self.importIntoRemotes)
>      --        for branch in branches.keys():
>      -+        for branch in list(branches.keys()):
>      -             if branch =3D=3D "master":
>      -                 branch =3D "main"
>      -             else:
>      -@@
>      -             self.updateOptionDict(description)
>      -
>      -             if not self.silent:
>      --                sys.stdout.write("\rImporting revision %s (%s%%)" =
% (change, cnt * 100 / len(changes)))
>      -+                sys.stdout.write("\rImporting revision %s (%4.1f%%=
)" % (change, cnt * 100 / len(changes)))
>      -                 sys.stdout.flush()
>      -             cnt =3D cnt + 1
>      -
>      -             try:
>      -                 if self.detectBranches:
>      -                     branches =3D self.splitFilesIntoBranches(descr=
iption)
>      --                    for branch in branches.keys():
>      -+                    for branch in list(branches.keys()):
>      -                         ## HACK  --hwn
>      -                         branchPrefix =3D self.depotPaths[0] + bran=
ch + "/"
>      -                         self.branchPrefixes =3D [ branchPrefix ]
>      -@@
>      -                 sys.exit(1)
>      -
>      -     def sync_origin_only(self):
>      -+        """ Ensures that the origin has been synchronized if one i=
s set """
>      -         if self.syncWithOrigin:
>      -             self.hasOrigin =3D originP4BranchesExist()
>      -             if self.hasOrigin:
>       @@
>                        system("git fetch origin")
>
>      @@ -1439,61 +671,6 @@
>            def closeStreams(self):
>                self.gitStream.close()
>       @@
>      -                 if short in branches:
>      -                     self.p4BranchesInGit =3D [ short ]
>      -             else:
>      --                self.p4BranchesInGit =3D branches.keys()
>      -+                self.p4BranchesInGit =3D list(branches.keys())
>      -
>      -             if len(self.p4BranchesInGit) > 1:
>      -                 if not self.silent:
>      -                     print("Importing from/into multiple branches")
>      -                 self.detectBranches =3D True
>      --                for branch in branches.keys():
>      -+                for branch in list(branches.keys()):
>      -                     self.initialParents[self.refPrefix + branch] =
=3D \
>      -                         branches[branch]
>      -
>      -@@
>      -                                  help=3D"where to leave result of =
the clone"),
>      -             optparse.make_option("--bare", dest=3D"cloneBare",
>      -                                  action=3D"store_true", default=3D=
False),
>      -+            optparse.make_option("--encoding", dest=3D"setPathEnco=
ding",
>      -+                                 action=3D"store", default=3DNone,
>      -+                                 help=3D"Sets the path encoding fo=
r this depot")
>      -         ]
>      -         self.cloneDestination =3D None
>      -         self.needsGit =3D False
>      -         self.cloneBare =3D False
>      -+        self.setPathEncoding =3D None
>      -
>      -     def defaultDestination(self, args):
>      -+        """Returns the last path component as the default git
>      -+        repository directory name"""
>      -         ## TODO: use common prefix of args?
>      -         depotPath =3D args[0]
>      -         depotDir =3D re.sub("(@[^@]*)$", "", depotPath)
>      -         depotDir =3D re.sub("(#[^#]*)$", "", depotDir)
>      -         depotDir =3D re.sub(r"\.\.\.$", "", depotDir)
>      -         depotDir =3D re.sub(r"/$", "", depotDir)
>      --        return os.path.split(depotDir)[1]
>      -+        return depotDir.split('/')[-1]
>      -
>      -     def run(self, args):
>      -         if len(args) < 1:
>      -@@
>      -
>      -         depotPaths =3D args
>      -
>      -+        # If we have an encoding provided, ignore what may already=
 exist
>      -+        # in the registry. This will ensure we show the displayed =
values
>      -+        # using the correct encoding.
>      -+        if self.setPathEncoding:
>      -+            gitConfigSet("git-p4.pathEncoding", self.setPathEncodi=
ng)
>      -+
>      -+        # If more than 1 path element is supplied, the last elemen=
t
>      -+        # is the clone destination.
>      -         if not self.cloneDestination and len(depotPaths) > 1:
>                    self.cloneDestination =3D depotPaths[-1]
>                    depotPaths =3D depotPaths[:-1]
>
>      @@ -1512,177 +689,3 @@
>
>                if not os.path.exists(self.cloneDestination):
>                    os.makedirs(self.cloneDestination)
>      -@@
>      -         if retcode:
>      -             raise CalledProcessError(retcode, init_cmd)
>      -
>      -+        # Set the encoding if it was provided command line
>      -+        if self.setPathEncoding:
>      -+            init_cmd=3D ["git", "config", "git-p4.pathEncoding", s=
elf.setPathEncoding]
>      -+            retcode =3D subprocess.call(init_cmd)
>      -+            if retcode:
>      -+                raise CalledProcessError(retcode, init_cmd)
>      -+
>      -         if not P4Sync.run(self, depotPaths):
>      -             return False
>      -
>      -@@
>      -             to find the P4 commit we are based on, and the depot-p=
aths.
>      -         """
>      -
>      --        for parent in (range(65535)):
>      -+        for parent in (list(range(65535))):
>      -             log =3D extractLogMessageFromGitCommit("{0}^{1}".forma=
t(starting_point, parent))
>      -             settings =3D extractSettingsGitLog(log)
>      -             if 'change' in settings:
>      -@@
>      -             print("%s <=3D %s (%s)" % (branch, ",".join(settings["=
depot-paths"]), settings["change"]))
>      -         return True
>      -
>      -+class Py23File():
>      -+    """ Python2/3 Unicode File Wrapper
>      -+    """
>      -+
>      -+    stream_handle =3D None
>      -+    verbose       =3D False
>      -+    debug_handle  =3D None
>      -+
>      -+    def __init__(self, stream_handle, verbose =3D False,
>      -+                 debug_handle =3D None):
>      -+        """ Create a Python3 compliant Unicode to Byte String
>      -+            Windows compatible wrapper
>      -+
>      -+            stream_handle =3D the underlying file-like handle
>      -+            verbose       =3D Boolean if content should be echoed
>      -+            debug_handle  =3D A file-like handle data is duplicate=
ly written to
>      -+        """
>      -+        self.stream_handle =3D stream_handle
>      -+        self.verbose       =3D verbose
>      -+        self.debug_handle  =3D debug_handle
>      -+
>      -+    def write(self, utf8string):
>      -+        """ Writes the utf8 encoded string to the underlying
>      -+            file stream
>      -+        """
>      -+        self.stream_handle.write(as_bytes(utf8string))
>      -+        if self.verbose:
>      -+            sys.stderr.write("Stream Output: %s" % utf8string)
>      -+            sys.stderr.flush()
>      -+        if self.debug_handle:
>      -+            self.debug_handle.write(as_bytes(utf8string))
>      -+
>      -+    def read(self, size =3D None):
>      -+        """ Reads int charcters from the underlying stream
>      -+            and converts it to utf8.
>      -+
>      -+            Be aware, the size value is for reading the underlying
>      -+            bytes so the value may be incorrect. Usage of the size
>      -+            value is discouraged.
>      -+        """
>      -+        if size =3D=3D None:
>      -+            return as_string(self.stream_handle.read())
>      -+        else:
>      -+            return as_string(self.stream_handle.read(size))
>      -+
>      -+    def readline(self):
>      -+        """ Reads a line from the underlying byte stream
>      -+            and converts it to utf8
>      -+        """
>      -+        return as_string(self.stream_handle.readline())
>      -+
>      -+    def readlines(self, sizeHint =3D None):
>      -+        """ Returns a list containing lines from the file converte=
d to unicode.
>      -+
>      -+            sizehint - Optional. If the optional sizehint argument=
 is
>      -+            present, instead of reading up to EOF, whole lines tot=
alling
>      -+            approximately sizehint bytes are read.
>      -+        """
>      -+        lines =3D self.stream_handle.readlines(sizeHint)
>      -+        for i in range(0, len(lines)):
>      -+            lines[i] =3D as_string(lines[i])
>      -+        return lines
>      -+
>      -+    def close(self):
>      -+        """ Closes the underlying byte stream """
>      -+        self.stream_handle.close()
>      -+
>      -+    def flush(self):
>      -+        """ Flushes the underlying byte stream """
>      -+        self.stream_handle.flush()
>      -+
>      -+class DepotPath():
>      -+    """ Describes a DepotPath or File
>      -+    """
>      -+
>      -+    raw_path =3D None
>      -+    utf8_path =3D None
>      -+    bytes_path =3D None
>      -+
>      -+    def __init__(self, path):
>      -+        """ Creates a new DepotPath with the path encoded
>      -+            with by the P4 repository
>      -+        """
>      -+        raw_path =3D path
>      -+
>      -+    def raw():
>      -+        """ Returns the path as it was originally found
>      -+            in the P4 repository
>      -+        """
>      -+        return raw_path
>      -+
>      -+    def startswith(self, prefix, start =3D None, end =3D None):
>      -+        """ Return True if string starts with the prefix, otherwis=
e
>      -+            return False. prefix can also be a tuple of prefixes t=
o
>      -+            look for. With optional start, test string beginning a=
t
>      -+            that position. With optional end, stop comparing
>      -+            string at that position.
>      -+        """
>      -+        return raw_path.startswith(prefix, start, end)
>      -+
>      -+
>      - class HelpFormatter(optparse.IndentedHelpFormatter):
>      -     def __init__(self):
>      -         optparse.IndentedHelpFormatter.__init__(self)
>      -@@
>      -
>      - def main():
>      -     if len(sys.argv[1:]) =3D=3D 0:
>      --        printUsage(commands.keys())
>      -+        printUsage(list(commands.keys()))
>      -         sys.exit(2)
>      -
>      -     cmdName =3D sys.argv[1]
>      -@@
>      -     except KeyError:
>      -         print("unknown command %s" % cmdName)
>      -         print("")
>      --        printUsage(commands.keys())
>      -+        printUsage(list(commands.keys()))
>      -         sys.exit(2)
>      -
>      -     options =3D cmd.options
>      -@@
>      -                                    description =3D cmd.description=
,
>      -                                    formatter =3D HelpFormatter())
>      -
>      --    (cmd, args) =3D parser.parse_args(sys.argv[2:], cmd);
>      -+    try:
>      -+        (cmd, args) =3D parser.parse_args(sys.argv[2:], cmd);
>      -+    except:
>      -+        parser.print_help()
>      -+        raise
>      -+
>      -     global verbose
>      -     verbose =3D cmd.verbose
>      -     if cmd.needsGit:
>      -@@
>      -                         chdir(cdup);
>      -
>      -         if not isValidGitDir(cmd.gitdir):
>      --            if isValidGitDir(cmd.gitdir + "/.git"):
>      --                cmd.gitdir +=3D "/.git"
>      -+            if isValidGitDir(os.path.join(cmd.gitdir, ".git")):
>      -+                cmd.gitdir =3D os.path.join(cmd.gitdir, ".git")
>      -             else:
>      -                 die("fatal: cannot locate git repository at %s" % =
cmd.gitdir)
>      -
>   -:  ---------- > 11:  883ef45ca5 git-p4: Added --encoding parameter to =
p4 clone
>
> --
> gitgitgadget
