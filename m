Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E565C433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 20:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355846AbiDSUg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357088AbiDSUg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 16:36:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7193FBCF
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 13:33:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id s18so35369234ejr.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 13:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L1GdTvtmCpt3CkH+iTorizrUF3xc0zUMtB5a4n/VUoE=;
        b=DSibSJe+DMU9VuOV4G5KQXXTcz8fwqofRuprL6oJqgfgTvbrkSMJeNPODlo2sloCXd
         NG1xlP59JHxWmfuxrqCi9agFOjYSS7P71qPW1I/C253M6+jiqwjTgQ/7jS9gj8+xmwxv
         30F8PSmY1QDEiKUwowf93elIu4xE4yDm8eVn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L1GdTvtmCpt3CkH+iTorizrUF3xc0zUMtB5a4n/VUoE=;
        b=TYVtk+yW6hKob8XJfUYMk70QkovNIlNa68+E8t84hgh8s1zPXaqCgGFtKhFNAbBTE5
         PLY6JD352vHa6oaT9iKYzyIzCPQPmGEeQd2AIb/uaQBWuAbO2qtyP/OEPlO1EbbhQfwm
         Y0ivcGRPejBlwm+tLuF9z3ZK5muYa+OzgjpVa8EJvXi71U62fSvnRAjr7CQIXHDEc1C9
         Dag2M4wme/IQrMKfj6R5u9+hR7S715Np2bX9wlvlZ9At/IGN3Z0XK1X1k6ltO93s7ANH
         3mfallu9fdb8/9P5m5JUbf8+iUm4RiswVbm9QTmRx8kmAoAQYsZf4VHcuUM068bkCSE8
         roEw==
X-Gm-Message-State: AOAM532T4DsmS8s/ONd4ao6UK/PkWxe2fgr3+UhKeDVXw9X9JbbCEtCm
        t5opNnHFuT6d/os2b3D6uOI3SsihJcrtwRCXsl0Rhw==
X-Google-Smtp-Source: ABdhPJz4/tN48jBVlDcr6Da9LA9xYb+PALeIPX+9lVPQsmsiKKRU9sF5hvvO9OFS8T2kDe2Cvj1YHytTDrxrQ+kzmcM=
X-Received: by 2002:a17:906:4ad9:b0:6cf:93f:f77e with SMTP id
 u25-20020a1709064ad900b006cf093ff77emr15288419ejt.558.1650400418703; Tue, 19
 Apr 2022 13:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1206.v2.git.1649831069578.gitgitgadget@gmail.com> <pull.1206.v3.git.1650399590844.gitgitgadget@gmail.com>
In-Reply-To: <pull.1206.v3.git.1650399590844.gitgitgadget@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 19 Apr 2022 22:33:27 +0200
Message-ID: <CAPMMpogSt_Soih=DvMgb71nPxo-jkiVS5XF3iw40vkuo2W+8Sg@mail.gmail.com>
Subject: Re: [PATCH v3] git-p4: improve encoding handling to support
 inconsistent encodings
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My apologies, I messed up the cover letter, *and* the subject line,
and now GitGitGadget won't let me submit the same commit again...

The subject line *should* have read: Git p4 encoding strategy


The cover letter (after "---") should have read:
---
This is no longer RFC, it's now request-for-Review!

Changes wrt v2:
 * Renamed "legacy" strategy to "passthrough", reflecting the possible
value of maintaining it long-term
 * Changed "fallback decoding failure" behavior to escape over-127
bytes, instead of omitting them. There should now be no information
loss under any scenario, although recovering the original bytes might
be non-trivial

On Tue, Apr 19, 2022 at 10:19 PM Tao Klerks via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Tao Klerks <tao@klerks.biz>
>
> git-p4 is designed to run correctly under python2.7 and python3, but
> its functional behavior wrt importing user-entered text differs across
> these environments:
>
> Under python2, git-p4 "naively" writes the Perforce bytestream into git
> metadata (and does not set an "encoding" header on the commits); this
> means that any non-utf-8 byte sequences end up creating invalidly-encoded
> commit metadata in git.
>
> Under python3, git-p4 attempts to decode the Perforce bytestream as utf-8
> data, and fails badly (with an unhelpful error) when non-utf-8 data is
> encountered.
>
> Perforce clients (especially p4v) encourage user entry of changelist
> descriptions (and user full names) in OS-local encoding, and store the
> resulting bytestream to the server unmodified - such that different
> clients can end up creating mutually-unintelligible messages. The most
> common inconsistency, in many Perforce environments, is likely to be utf-=
8
> (typical in linux) vs cp-1252 (typical in windows).
>
> Make the changelist-description- and user-fullname-handling code
> python-runtime-agnostic, introducing three "strategies" selectable via
> config:
> - 'passthrough', behaving as previously under python2,
> - 'strict', behaving as previously under python3, and
> - 'fallback', favoring utf-8 but supporting a secondary encoding when
> utf-8 decoding fails, and finally escaping high-range bytes if the
> decoding with the secondary encoding also fails.
>
> Keep the python2 default behavior as-is ('legacy' strategy), but switch
> the python3 default strategy to 'fallback' with default fallback encoding
> 'cp1252'.
>
> Also include tests exercising these encoding strategies, documentation fo=
r
> the new config, and improve the user-facing error messages when decoding
> does fail.
>
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
>     RFC: Git p4 encoding strategy
>
>     OPEN QUESTIONS:
>
>      * Does it make sense to make "fallback" the default decoding strateg=
y
>        in python3? This is definitely a change in behavior, but I believe
>        for the better; failing with "we defaulted to strict, but you can =
run
>        again with this other option if you want it to work" seems unkind,
>        only making sense if we thought fallback to cp1252 would be wrong =
in
>        a substantial proportion of cases...
>      * Is it OK to duplicate the bulk of the testing code across
>        t9835-git-p4-metadata-encoding-python2.sh and
>        t9836-git-p4-metadata-encoding-python3.sh?
>      * Is it OK to explicitly call "git-p4.py" in tests, rather than the
>        build output "git-p4", in order to be able to select the python
>        runtime on a per-test basis? Is there a better approach?
>      * Is the naming of the strategies appropriate? Should the default
>        python2 strategy be called something less opinionated, like
>        "passthrough"?
>
>     Changes wrt v1:
>
>      * Added "and replace any remaining unmappable bytes" behavior to the
>        "fallback" strategy; common reasonable encodings like cp1252 still
>        contain unmapped codepoints, and if those are found, there is real=
ly
>        nothing that can be done about it other than ignoring the crazy
>        bytes; this approach is consistent with the longstanding
>        path-encoding-handling strategy.
>      * Simplified error-handling accordingly
>      * Cleaned up tests & commit messages slightly
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1206%2F=
TaoK%2Fgit-p4-encoding-strategy-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1206/TaoK/=
git-p4-encoding-strategy-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1206
>
> Range-diff vs v2:
>
>  1:  6d227ad57ea ! 1:  1d83b6d7865 [RFC] git-p4: improve encoding handlin=
g to support inconsistent encodings
>      @@ Metadata
>       Author: Tao Klerks <tao@klerks.biz>
>
>        ## Commit message ##
>      -    [RFC] git-p4: improve encoding handling to support inconsistent=
 encodings
>      +    git-p4: improve encoding handling to support inconsistent encod=
ings
>
>           git-p4 is designed to run correctly under python2.7 and python3=
, but
>           its functional behavior wrt importing user-entered text differs=
 across
>      @@ Commit message
>           Make the changelist-description- and user-fullname-handling cod=
e
>           python-runtime-agnostic, introducing three "strategies" selecta=
ble via
>           config:
>      -    - 'legacy', behaving as previously under python2,
>      +    - 'passthrough', behaving as previously under python2,
>           - 'strict', behaving as previously under python3, and
>           - 'fallback', favoring utf-8 but supporting a secondary encodin=
g when
>      -    utf-8 decoding fails, and finally replacing remaining unmappabl=
e bytes.
>      +    utf-8 decoding fails, and finally escaping high-range bytes if =
the
>      +    decoding with the secondary encoding also fails.
>
>           Keep the python2 default behavior as-is ('legacy' strategy), bu=
t switch
>      -    the python3 default strategy to 'fallback' with fallback encodi=
ng
>      +    the python3 default strategy to 'fallback' with default fallbac=
k encoding
>           'cp1252'.
>
>           Also include tests exercising these encoding strategies, docume=
ntation for
>      @@ Documentation/git-p4.txt: git-p4.pathEncoding::
>       +git-p4.metadataDecodingStrategy::
>       + Perforce keeps the encoding of a changelist descriptions and user
>       + full names as stored by the client on a given OS. The p4v client
>      -+ uses the OS-local encosing, and so different users can end up sto=
ring
>      ++ uses the OS-local encoding, and so different users can end up sto=
ring
>       + different changelist descriptions or user full names in different
>       + encodings, in the same depot.
>       + Git tolerates inconsistent/incorrect encodings in commit messages
>       + and author names, but expects them to be specified in utf-8.
>       + git-p4 can use three different decoding strategies in handling th=
e
>      -+ encoding uncertainty in Perforce: 'legacy' simply passes the orig=
inal
>      -+ bytes through from Perforce to git, creating usable but
>      ++ encoding uncertainty in Perforce: 'passthrough' simply passes the
>      ++ original bytes through from Perforce to git, creating usable but
>       + incorrectly-encoded data when the Perforce data is encoded as
>       + anything other than utf-8. 'strict' expects the Perforce data to =
be
>       + encoded as utf-8, and fails to import when this is not true.
>       + 'fallback' attempts to interpret the data as utf-8, and otherwise
>       + falls back to using a secondary encoding - by default the common
>      -+ windows encoding 'cp-1252' - with any remaining unparseable bytes
>      -+ replaced with a placeholder character.
>      -+ Under python2 the default strategy is 'legacy' for historical
>      ++ windows encoding 'cp-1252' - with upper-range bytes escaped if
>      ++ decoding with the fallback encoding also fails.
>      ++ Under python2 the default strategy is 'passthrough' for historica=
l
>       + reasons, and under python3 the default is 'fallback'.
>       + When 'strict' is selected and decoding fails, the error message w=
ill
>       + propose changing this config parameter as a workaround. If this
>      @@ Documentation/git-p4.txt: git-p4.pathEncoding::
>         Specify the system that is used for large (binary) files. Please =
note
>
>        ## git-p4.py ##
>      +@@
>      + # pylint: disable=3Dtoo-many-statements,too-many-instance-attribut=
es
>      + # pylint: disable=3Dtoo-many-branches,too-many-nested-blocks
>      + #
>      ++import struct
>      + import sys
>      + if sys.version_info.major < 3 and sys.version_info.minor < 7:
>      +     sys.stderr.write("git-p4: requires Python 2.7 or later.\n")
>       @@ git-p4.py: defaultLabelRegexp =3D r'[a-zA-Z0-9_\-.]+$'
>        # The block size is reduced automatically if required
>        defaultBlockSize =3D 1<<20
>
>      -+defaultMetadataDecodingStrategy =3D 'legacy' if sys.version_info.m=
ajor =3D=3D 2 else 'fallback'
>      ++defaultMetadataDecodingStrategy =3D 'passthrough' if sys.version_i=
nfo.major =3D=3D 2 else 'fallback'
>       +defaultFallbackMetadataEncoding =3D 'cp1252'
>       +
>        p4_access_checked =3D False
>      @@ git-p4.py: else:
>       +defaulting to cp1252.""".format(self.input_string)
>       +
>       +
>      ++encoding_fallback_warning_issued =3D False
>      ++encoding_escape_warning_issued =3D False
>       +def metadata_stream_to_writable_bytes(s):
>       +    encodingStrategy =3D gitConfig('git-p4.metadataDecodingStrateg=
y') or defaultMetadataDecodingStrategy
>       +    fallbackEncoding =3D gitConfig('git-p4.metadataFallbackEncodin=
g') or defaultFallbackMetadataEncoding
>       +    if not isinstance(s, bytes):
>       +        return s.encode('utf_8')
>      -+    if encodingStrategy =3D=3D 'legacy':
>      ++    if encodingStrategy =3D=3D 'passthrough':
>       +        return s
>       +    try:
>       +        s.decode('utf_8')
>       +        return s
>       +    except UnicodeDecodeError:
>       +        if encodingStrategy =3D=3D 'fallback' and fallbackEncoding=
:
>      -+            return s.decode(fallbackEncoding, errors=3D'replace').=
encode('utf_8')
>      ++            global encoding_fallback_warning_issued
>      ++            global encoding_escape_warning_issued
>      ++            try:
>      ++                if not encoding_fallback_warning_issued:
>      ++                    print("\nCould not decode value as utf-8; usin=
g configured fallback encoding %s: %s" % (fallbackEncoding, s))
>      ++                    print("\n(this warning is only displayed once =
during an import)")
>      ++                    encoding_fallback_warning_issued =3D True
>      ++                return s.decode(fallbackEncoding).encode('utf_8')
>      ++            except Exception as exc:
>      ++                if not encoding_escape_warning_issued:
>      ++                    print("\nCould not decode value with configure=
d fallback encoding %s; escaping bytes over 127: %s" % (fallbackEncoding, s=
))
>      ++                    print("\n(this warning is only displayed once =
during an import)")
>      ++                    encoding_escape_warning_issued =3D True
>      ++                escaped_bytes =3D b''
>      ++                # bytes and strings work very differently in pytho=
n2 vs python3...
>      ++                if str is bytes:
>      ++                    for byte in s:
>      ++                        byte_number =3D struct.unpack('>B', byte)[=
0]
>      ++                        if byte_number > 127:
>      ++                            escaped_bytes +=3D b'%'
>      ++                            escaped_bytes +=3D hex(byte_number)[2:=
].upper()
>      ++                        else:
>      ++                            escaped_bytes +=3D byte
>      ++                else:
>      ++                    for byte_number in s:
>      ++                        if byte_number > 127:
>      ++                            escaped_bytes +=3D b'%'
>      ++                            escaped_bytes +=3D hex(byte_number).up=
per().encode()[2:]
>      ++                        else:
>      ++                            escaped_bytes +=3D bytes([byte_number]=
)
>      ++                return escaped_bytes
>      ++
>       +        raise MetadataDecodingException(s)
>       +
>        def decode_path(path):
>      @@ git-p4.py: class P4UserMap:
>       +            # "FullName" is bytes. "Email" on the other hand might=
 be bytes
>       +            # or unicode string depending on whether we are runnin=
g under
>       +            # python2 or python3. To support
>      -+            # git-p4.metadataDecodingStrategy=3Dlegacy, self.users=
 dict values
>      ++            # git-p4.metadataDecodingStrategy=3Dfallback, self.use=
rs dict values
>       +            # are always bytes, ready to be written to git.
>       +            emailbytes =3D metadata_stream_to_writable_bytes(outpu=
t["Email"])
>       +            self.users[output["User"]] =3D output["FullName"] + b"=
 <" + emailbytes + b">"
>      @@ t/t9835-git-p4-metadata-encoding-python2.sh (new)
>       +         touch file3 &&
>       +         p4 add file3 &&
>       +         p4 submit -d "$(echo third CL has s=C5=93me cp-1252 t=C3=
=A6xt |
>      -+           iconv -f utf8 -t cp1252)"
>      ++           iconv -f utf8 -t cp1252)" &&
>      ++
>      ++         p4_add_user "cp850_author" "$(echo =C3=85uthor |
>      ++                 iconv -f utf8 -t cp850)" &&
>      ++         P4USER=3Dcp850_author &&
>      ++         touch file4 &&
>      ++         p4 add file4 &&
>      ++         p4 submit -d "$(echo fourth CL h=C3=85s some cp850 text |
>      ++                 iconv -f utf8 -t cp850)"
>       + )
>       +'
>       +
>      @@ t/t9835-git-p4-metadata-encoding-python2.sh (new)
>       + grep "Decoding perforce metadata failed!" err
>       +'
>       +
>      -+test_expect_success 'check utf-8 contents with legacy strategy' '
>      ++test_expect_success 'check utf-8 contents with passthrough strateg=
y' '
>       + test_when_finished cleanup_git &&
>       + test_when_finished remove_user_cache &&
>      -+ git -c git-p4.metadataDecodingStrategy=3Dlegacy p4.py clone --des=
t=3D"$git" //depot@all &&
>      ++ git -c git-p4.metadataDecodingStrategy=3Dpassthrough p4.py clone =
--dest=3D"$git" //depot@all &&
>       + (
>       +         cd "$git" &&
>       +         git log >actual &&
>      @@ t/t9835-git-p4-metadata-encoding-python2.sh (new)
>       + )
>       +'
>       +
>      -+test_expect_success 'check latin-1 contents corrupted in git with =
legacy strategy' '
>      ++test_expect_success 'check latin-1 contents corrupted in git with =
passthrough strategy' '
>       + test_when_finished cleanup_git &&
>       + test_when_finished remove_user_cache &&
>      -+ git -c git-p4.metadataDecodingStrategy=3Dlegacy p4.py clone --des=
t=3D"$git" //depot@all &&
>      ++ git -c git-p4.metadataDecodingStrategy=3Dpassthrough p4.py clone =
--dest=3D"$git" //depot@all &&
>       + (
>       +         cd "$git" &&
>       +         git log >actual &&
>      @@ t/t9835-git-p4-metadata-encoding-python2.sh (new)
>       + )
>       +'
>       +
>      ++test_expect_success 'check cp850 contents parsed with correct fall=
back' '
>      ++ test_when_finished cleanup_git &&
>      ++ test_when_finished remove_user_cache &&
>      ++ git -c git-p4.metadataDecodingStrategy=3Dfallback -c git-p4.metad=
ataFallbackEncoding=3Dcp850 p4.py clone --dest=3D"$git" //depot@all &&
>      ++ (
>      ++         cd "$git" &&
>      ++         git log >actual &&
>      ++         grep "h=C3=85s some cp850 text" actual &&
>      ++         grep "=C3=85uthor" actual
>      ++ )
>      ++'
>      ++
>      ++test_expect_success 'check cp850-only contents escaped when cp1252=
 is fallback' '
>      ++ test_when_finished cleanup_git &&
>      ++ test_when_finished remove_user_cache &&
>      ++ git -c git-p4.metadataDecodingStrategy=3Dfallback p4.py clone --d=
est=3D"$git" //depot@all &&
>      ++ (
>      ++         cd "$git" &&
>      ++         git log >actual &&
>      ++         grep "h%8Fs some cp850 text" actual &&
>      ++         grep "%8Futhor" actual
>      ++ )
>      ++'
>      ++
>       +test_expect_success 'check cp-1252 contents on later sync after cl=
one with fallback strategy' '
>       + test_when_finished cleanup_git &&
>       + test_when_finished remove_user_cache &&
>      @@ t/t9835-git-p4-metadata-encoding-python2.sh (new)
>       + (
>       +         cd "$cli" &&
>       +         P4USER=3Dcp1252_author &&
>      -+         touch file4 &&
>      -+         p4 add file4 &&
>      -+         p4 submit -d "$(echo fourth CL has s=C5=93me more cp-1252=
 t=C3=A6xt |
>      ++         touch file10 &&
>      ++         p4 add file10 &&
>      ++         p4 submit -d "$(echo later CL has s=C5=93me more cp-1252 =
t=C3=A6xt |
>       +                 iconv -f utf8 -t cp1252)"
>       + ) &&
>       + (
>      @@ t/t9835-git-p4-metadata-encoding-python2.sh (new)
>       +         git p4.py sync --branch=3Dmaster &&
>       +
>       +         git log p4/master >actual &&
>      -+         cat actual &&
>       +         grep "s=C5=93me more cp-1252 t=C3=A6xt" actual &&
>       +         grep "=C3=A6uth=C5=93r" actual
>       + )
>      @@ t/t9835-git-p4-metadata-encoding-python2.sh (new)
>       +## / END REPEATED SECTION ##
>       +############################
>       +
>      -+test_expect_success 'legacy (latin-1 contents corrupted in git) is=
 the default with python2' '
>      ++test_expect_success 'passthrough (latin-1 contents corrupted in gi=
t) is the default with python2' '
>       + test_when_finished cleanup_git &&
>       + test_when_finished remove_user_cache &&
>      -+ git -c git-p4.metadataDecodingStrategy=3Dlegacy p4.py clone --des=
t=3D"$git" //depot@all &&
>      ++ git -c git-p4.metadataDecodingStrategy=3Dpassthrough p4.py clone =
--dest=3D"$git" //depot@all &&
>       + (
>       +         cd "$git" &&
>       +         git log >actual &&
>      @@ t/t9836-git-p4-metadata-encoding-python3.sh (new)
>       +         touch file3 &&
>       +         p4 add file3 &&
>       +         p4 submit -d "$(echo third CL has s=C5=93me cp-1252 t=C3=
=A6xt |
>      -+           iconv -f utf8 -t cp1252)"
>      ++           iconv -f utf8 -t cp1252)" &&
>      ++
>      ++         p4_add_user "cp850_author" "$(echo =C3=85uthor |
>      ++                 iconv -f utf8 -t cp850)" &&
>      ++         P4USER=3Dcp850_author &&
>      ++         touch file4 &&
>      ++         p4 add file4 &&
>      ++         p4 submit -d "$(echo fourth CL h=C3=85s some cp850 text |
>      ++                 iconv -f utf8 -t cp850)"
>       + )
>       +'
>       +
>      @@ t/t9836-git-p4-metadata-encoding-python3.sh (new)
>       + grep "Decoding perforce metadata failed!" err
>       +'
>       +
>      -+test_expect_success 'check utf-8 contents with legacy strategy' '
>      ++test_expect_success 'check utf-8 contents with passthrough strateg=
y' '
>       + test_when_finished cleanup_git &&
>       + test_when_finished remove_user_cache &&
>      -+ git -c git-p4.metadataDecodingStrategy=3Dlegacy p4.py clone --des=
t=3D"$git" //depot@all &&
>      ++ git -c git-p4.metadataDecodingStrategy=3Dpassthrough p4.py clone =
--dest=3D"$git" //depot@all &&
>       + (
>       +         cd "$git" &&
>       +         git log >actual &&
>      @@ t/t9836-git-p4-metadata-encoding-python3.sh (new)
>       + )
>       +'
>       +
>      -+test_expect_success 'check latin-1 contents corrupted in git with =
legacy strategy' '
>      ++test_expect_success 'check latin-1 contents corrupted in git with =
passthrough strategy' '
>       + test_when_finished cleanup_git &&
>       + test_when_finished remove_user_cache &&
>      -+ git -c git-p4.metadataDecodingStrategy=3Dlegacy p4.py clone --des=
t=3D"$git" //depot@all &&
>      ++ git -c git-p4.metadataDecodingStrategy=3Dpassthrough p4.py clone =
--dest=3D"$git" //depot@all &&
>       + (
>       +         cd "$git" &&
>       +         git log >actual &&
>      @@ t/t9836-git-p4-metadata-encoding-python3.sh (new)
>       + )
>       +'
>       +
>      ++test_expect_success 'check cp850 contents parsed with correct fall=
back' '
>      ++ test_when_finished cleanup_git &&
>      ++ test_when_finished remove_user_cache &&
>      ++ git -c git-p4.metadataDecodingStrategy=3Dfallback -c git-p4.metad=
ataFallbackEncoding=3Dcp850 p4.py clone --dest=3D"$git" //depot@all &&
>      ++ (
>      ++         cd "$git" &&
>      ++         git log >actual &&
>      ++         grep "h=C3=85s some cp850 text" actual &&
>      ++         grep "=C3=85uthor" actual
>      ++ )
>      ++'
>      ++
>      ++test_expect_success 'check cp850-only contents escaped when cp1252=
 is fallback' '
>      ++ test_when_finished cleanup_git &&
>      ++ test_when_finished remove_user_cache &&
>      ++ git -c git-p4.metadataDecodingStrategy=3Dfallback p4.py clone --d=
est=3D"$git" //depot@all &&
>      ++ (
>      ++         cd "$git" &&
>      ++         git log >actual &&
>      ++         grep "h%8Fs some cp850 text" actual &&
>      ++         grep "%8Futhor" actual
>      ++ )
>      ++'
>      ++
>       +test_expect_success 'check cp-1252 contents on later sync after cl=
one with fallback strategy' '
>       + test_when_finished cleanup_git &&
>       + test_when_finished remove_user_cache &&
>      @@ t/t9836-git-p4-metadata-encoding-python3.sh (new)
>       + (
>       +         cd "$cli" &&
>       +         P4USER=3Dcp1252_author &&
>      -+         touch file4 &&
>      -+         p4 add file4 &&
>      -+         p4 submit -d "$(echo fourth CL has s=C5=93me more cp-1252=
 t=C3=A6xt |
>      ++         touch file10 &&
>      ++         p4 add file10 &&
>      ++         p4 submit -d "$(echo later CL has s=C5=93me more cp-1252 =
t=C3=A6xt |
>       +                 iconv -f utf8 -t cp1252)"
>       + ) &&
>       + (
>      @@ t/t9836-git-p4-metadata-encoding-python3.sh (new)
>       +         git p4.py sync --branch=3Dmaster &&
>       +
>       +         git log p4/master >actual &&
>      -+         cat actual &&
>       +         grep "s=C5=93me more cp-1252 t=C3=A6xt" actual &&
>       +         grep "=C3=A6uth=C5=93r" actual
>       + )
>
>
>  Documentation/git-p4.txt                    |  37 +++-
>  git-p4.py                                   | 123 +++++++++--
>  t/lib-git-p4.sh                             |   3 +-
>  t/t9835-git-p4-metadata-encoding-python2.sh | 213 +++++++++++++++++++
>  t/t9836-git-p4-metadata-encoding-python3.sh | 214 ++++++++++++++++++++
>  5 files changed, 572 insertions(+), 18 deletions(-)
>  create mode 100755 t/t9835-git-p4-metadata-encoding-python2.sh
>  create mode 100755 t/t9836-git-p4-metadata-encoding-python3.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index e21fcd8f712..de5ee6748e3 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -636,7 +636,42 @@ git-p4.pathEncoding::
>         Git expects paths encoded as UTF-8. Use this config to tell git-p=
4
>         what encoding Perforce had used for the paths. This encoding is u=
sed
>         to transcode the paths to UTF-8. As an example, Perforce on Windo=
ws
> -       often uses "cp1252" to encode path names.
> +       often uses "cp1252" to encode path names. If this option is passe=
d
> +       into a p4 clone request, it is persisted in the resulting new git
> +       repo.
> +
> +git-p4.metadataDecodingStrategy::
> +       Perforce keeps the encoding of a changelist descriptions and user
> +       full names as stored by the client on a given OS. The p4v client
> +       uses the OS-local encoding, and so different users can end up sto=
ring
> +       different changelist descriptions or user full names in different
> +       encodings, in the same depot.
> +       Git tolerates inconsistent/incorrect encodings in commit messages
> +       and author names, but expects them to be specified in utf-8.
> +       git-p4 can use three different decoding strategies in handling th=
e
> +       encoding uncertainty in Perforce: 'passthrough' simply passes the
> +       original bytes through from Perforce to git, creating usable but
> +       incorrectly-encoded data when the Perforce data is encoded as
> +       anything other than utf-8. 'strict' expects the Perforce data to =
be
> +       encoded as utf-8, and fails to import when this is not true.
> +       'fallback' attempts to interpret the data as utf-8, and otherwise
> +       falls back to using a secondary encoding - by default the common
> +       windows encoding 'cp-1252' - with upper-range bytes escaped if
> +       decoding with the fallback encoding also fails.
> +       Under python2 the default strategy is 'passthrough' for historica=
l
> +       reasons, and under python3 the default is 'fallback'.
> +       When 'strict' is selected and decoding fails, the error message w=
ill
> +       propose changing this config parameter as a workaround. If this
> +       option is passed into a p4 clone request, it is persisted into th=
e
> +       resulting new git repo.
> +
> +git-p4.metadataFallbackEncoding::
> +       Specify the fallback encoding to use when decoding Perforce autho=
r
> +       names and changelists descriptions using the 'fallback' strategy
> +       (see git-p4.metadataDecodingStrategy). The fallback encoding will
> +       only be used when decoding as utf-8 fails. This option defaults t=
o
> +       cp1252, a common windows encoding. If this option is passed into =
a
> +       p4 clone request, it is persisted into the resulting new git repo=
.
>
>  git-p4.largeFileSystem::
>         Specify the system that is used for large (binary) files. Please =
note
> diff --git a/git-p4.py b/git-p4.py
> index a9b1f904410..d24c3535f8a 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -15,6 +15,7 @@
>  # pylint: disable=3Dtoo-many-statements,too-many-instance-attributes
>  # pylint: disable=3Dtoo-many-branches,too-many-nested-blocks
>  #
> +import struct
>  import sys
>  if sys.version_info.major < 3 and sys.version_info.minor < 7:
>      sys.stderr.write("git-p4: requires Python 2.7 or later.\n")
> @@ -54,6 +55,9 @@ defaultLabelRegexp =3D r'[a-zA-Z0-9_\-.]+$'
>  # The block size is reduced automatically if required
>  defaultBlockSize =3D 1<<20
>
> +defaultMetadataDecodingStrategy =3D 'passthrough' if sys.version_info.ma=
jor =3D=3D 2 else 'fallback'
> +defaultFallbackMetadataEncoding =3D 'cp1252'
> +
>  p4_access_checked =3D False
>
>  re_ko_keywords =3D re.compile(br'\$(Id|Header)(:[^$\n]+)?\$')
> @@ -203,6 +207,70 @@ else:
>      def encode_text_stream(s):
>          return s.encode('utf_8') if isinstance(s, unicode) else s
>
> +
> +class MetadataDecodingException(Exception):
> +    def __init__(self, input_string):
> +        self.input_string =3D input_string
> +
> +    def __str__(self):
> +        return """Decoding perforce metadata failed!
> +The failing string was:
> +---
> +{}
> +---
> +Consider setting the git-p4.metadataDecodingStrategy config option to
> +'fallback', to allow metadata to be decoded using a fallback encoding,
> +defaulting to cp1252.""".format(self.input_string)
> +
> +
> +encoding_fallback_warning_issued =3D False
> +encoding_escape_warning_issued =3D False
> +def metadata_stream_to_writable_bytes(s):
> +    encodingStrategy =3D gitConfig('git-p4.metadataDecodingStrategy') or=
 defaultMetadataDecodingStrategy
> +    fallbackEncoding =3D gitConfig('git-p4.metadataFallbackEncoding') or=
 defaultFallbackMetadataEncoding
> +    if not isinstance(s, bytes):
> +        return s.encode('utf_8')
> +    if encodingStrategy =3D=3D 'passthrough':
> +        return s
> +    try:
> +        s.decode('utf_8')
> +        return s
> +    except UnicodeDecodeError:
> +        if encodingStrategy =3D=3D 'fallback' and fallbackEncoding:
> +            global encoding_fallback_warning_issued
> +            global encoding_escape_warning_issued
> +            try:
> +                if not encoding_fallback_warning_issued:
> +                    print("\nCould not decode value as utf-8; using conf=
igured fallback encoding %s: %s" % (fallbackEncoding, s))
> +                    print("\n(this warning is only displayed once during=
 an import)")
> +                    encoding_fallback_warning_issued =3D True
> +                return s.decode(fallbackEncoding).encode('utf_8')
> +            except Exception as exc:
> +                if not encoding_escape_warning_issued:
> +                    print("\nCould not decode value with configured fall=
back encoding %s; escaping bytes over 127: %s" % (fallbackEncoding, s))
> +                    print("\n(this warning is only displayed once during=
 an import)")
> +                    encoding_escape_warning_issued =3D True
> +                escaped_bytes =3D b''
> +                # bytes and strings work very differently in python2 vs =
python3...
> +                if str is bytes:
> +                    for byte in s:
> +                        byte_number =3D struct.unpack('>B', byte)[0]
> +                        if byte_number > 127:
> +                            escaped_bytes +=3D b'%'
> +                            escaped_bytes +=3D hex(byte_number)[2:].uppe=
r()
> +                        else:
> +                            escaped_bytes +=3D byte
> +                else:
> +                    for byte_number in s:
> +                        if byte_number > 127:
> +                            escaped_bytes +=3D b'%'
> +                            escaped_bytes +=3D hex(byte_number).upper().=
encode()[2:]
> +                        else:
> +                            escaped_bytes +=3D bytes([byte_number])
> +                return escaped_bytes
> +
> +        raise MetadataDecodingException(s)
> +
>  def decode_path(path):
>      """Decode a given string (bytes or otherwise) using configured path =
encoding options
>      """
> @@ -702,11 +770,12 @@ def p4CmdList(cmd, stdin=3DNone, stdin_mode=3D'w+b'=
, cb=3DNone, skip_info=3DFalse,
>              if bytes is not str:
>                  # Decode unmarshalled dict to use str keys and values, e=
xcept for:
>                  #   - `data` which may contain arbitrary binary data
> -                #   - `depotFile[0-9]*`, `path`, or `clientFile` which m=
ay contain non-UTF8 encoded text
> +                #   - `desc` or `FullName` which may contain non-UTF8 en=
coded text handled below, eagerly converted to bytes
> +                #   - `depotFile[0-9]*`, `path`, or `clientFile` which m=
ay contain non-UTF8 encoded text, handled by decode_path()
>                  decoded_entry =3D {}
>                  for key, value in entry.items():
>                      key =3D key.decode()
> -                    if isinstance(value, bytes) and not (key in ('data',=
 'path', 'clientFile') or key.startswith('depotFile')):
> +                    if isinstance(value, bytes) and not (key in ('data',=
 'desc', 'FullName', 'path', 'clientFile') or key.startswith('depotFile')):
>                          value =3D value.decode()
>                      decoded_entry[key] =3D value
>                  # Parse out data if it's an error response
> @@ -716,6 +785,10 @@ def p4CmdList(cmd, stdin=3DNone, stdin_mode=3D'w+b',=
 cb=3DNone, skip_info=3DFalse,
>              if skip_info:
>                  if 'code' in entry and entry['code'] =3D=3D 'info':
>                      continue
> +            if 'desc' in entry:
> +                entry['desc'] =3D metadata_stream_to_writable_bytes(entr=
y['desc'])
> +            if 'FullName' in entry:
> +                entry['FullName'] =3D metadata_stream_to_writable_bytes(=
entry['FullName'])
>              if cb is not None:
>                  cb(entry)
>              else:
> @@ -1435,7 +1508,13 @@ class P4UserMap:
>          for output in p4CmdList(["users"]):
>              if "User" not in output:
>                  continue
> -            self.users[output["User"]] =3D output["FullName"] + " <" + o=
utput["Email"] + ">"
> +            # "FullName" is bytes. "Email" on the other hand might be by=
tes
> +            # or unicode string depending on whether we are running unde=
r
> +            # python2 or python3. To support
> +            # git-p4.metadataDecodingStrategy=3Dfallback, self.users dic=
t values
> +            # are always bytes, ready to be written to git.
> +            emailbytes =3D metadata_stream_to_writable_bytes(output["Ema=
il"])
> +            self.users[output["User"]] =3D output["FullName"] + b" <" + =
emailbytes + b">"
>              self.emails[output["Email"]] =3D output["User"]
>
>          mapUserConfigRegex =3D re.compile(r"^\s*(\S+)\s*=3D\s*(.+)\s*<(\=
S+)>\s*$", re.VERBOSE)
> @@ -1445,26 +1524,28 @@ class P4UserMap:
>                  user =3D mapUser[0][0]
>                  fullname =3D mapUser[0][1]
>                  email =3D mapUser[0][2]
> -                self.users[user] =3D fullname + " <" + email + ">"
> +                fulluser =3D fullname + " <" + email + ">"
> +                self.users[user] =3D metadata_stream_to_writable_bytes(f=
ulluser)
>                  self.emails[email] =3D user
>
> -        s =3D ''
> +        s =3D b''
>          for (key, val) in self.users.items():
> -            s +=3D "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
> +            keybytes =3D metadata_stream_to_writable_bytes(key)
> +            s +=3D b"%s\t%s\n" % (keybytes.expandtabs(1), val.expandtabs=
(1))
>
> -        open(self.getUserCacheFilename(), 'w').write(s)
> +        open(self.getUserCacheFilename(), 'wb').write(s)
>          self.userMapFromPerforceServer =3D True
>
>      def loadUserMapFromCache(self):
>          self.users =3D {}
>          self.userMapFromPerforceServer =3D False
>          try:
> -            cache =3D open(self.getUserCacheFilename(), 'r')
> +            cache =3D open(self.getUserCacheFilename(), 'rb')
>              lines =3D cache.readlines()
>              cache.close()
>              for line in lines:
> -                entry =3D line.strip().split("\t")
> -                self.users[entry[0]] =3D entry[1]
> +                entry =3D line.strip().split(b"\t")
> +                self.users[entry[0].decode('utf_8')] =3D entry[1]
>          except IOError:
>              self.getUserMapFromPerforceServer()
>
> @@ -3020,7 +3101,8 @@ class P4Sync(Command, P4UserMap):
>          if userid in self.users:
>              return self.users[userid]
>          else:
> -            return "%s <a@b>" % userid
> +            userid_bytes =3D metadata_stream_to_writable_bytes(userid)
> +            return b"%s <a@b>" % userid_bytes
>
>      def streamTag(self, gitStream, labelName, labelDetails, commit, epoc=
h):
>          """ Stream a p4 tag.
> @@ -3043,9 +3125,10 @@ class P4Sync(Command, P4UserMap):
>              email =3D self.make_email(owner)
>          else:
>              email =3D self.make_email(self.p4UserId())
> -        tagger =3D "%s %s %s" % (email, epoch, self.tz)
>
> -        gitStream.write("tagger %s\n" % tagger)
> +        gitStream.write("tagger ")
> +        gitStream.write(email)
> +        gitStream.write(" %s %s\n" % (epoch, self.tz))
>
>          print("labelDetails=3D",labelDetails)
>          if 'Description' in labelDetails:
> @@ -3138,12 +3221,12 @@ class P4Sync(Command, P4UserMap):
>          self.gitStream.write("commit %s\n" % branch)
>          self.gitStream.write("mark :%s\n" % details["change"])
>          self.committedChanges.add(int(details["change"]))
> -        committer =3D ""
>          if author not in self.users:
>              self.getUserMapFromPerforceServer()
> -        committer =3D "%s %s %s" % (self.make_email(author), epoch, self=
.tz)
>
> -        self.gitStream.write("committer %s\n" % committer)
> +        self.gitStream.write("committer ")
> +        self.gitStream.write(self.make_email(author))
> +        self.gitStream.write(" %s %s\n" % (epoch, self.tz))
>
>          self.gitStream.write("data <<EOT\n")
>          self.gitStream.write(details["desc"])
> @@ -4055,6 +4138,14 @@ class P4Clone(P4Sync):
>          if self.useClientSpec_from_options:
>              system(["git", "config", "--bool", "git-p4.useclientspec", "=
true"])
>
> +        # persist any git-p4 encoding-handling config options passed in =
for clone:
> +        if gitConfig('git-p4.metadataDecodingStrategy'):
> +            system(["git", "config", "git-p4.metadataDecodingStrategy", =
gitConfig('git-p4.metadataDecodingStrategy')])
> +        if gitConfig('git-p4.metadataFallbackEncoding'):
> +            system(["git", "config", "git-p4.metadataFallbackEncoding", =
gitConfig('git-p4.metadataFallbackEncoding')])
> +        if gitConfig('git-p4.pathEncoding'):
> +            system(["git", "config", "git-p4.pathEncoding", gitConfig('g=
it-p4.pathEncoding')])
> +
>          return True
>
>  class P4Unshelve(Command):
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index 5aff2abe8b5..2a5b8738ea3 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -142,10 +142,11 @@ start_p4d () {
>
>  p4_add_user () {
>         name=3D$1 &&
> +       fullname=3D"${2:-Dr. $1}"
>         p4 user -f -i <<-EOF
>         User: $name
>         Email: $name@example.com
> -       FullName: Dr. $name
> +       FullName: $fullname
>         EOF
>  }
>
> diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4=
-metadata-encoding-python2.sh
> new file mode 100755
> index 00000000000..036bf79c667
> --- /dev/null
> +++ b/t/t9835-git-p4-metadata-encoding-python2.sh
> @@ -0,0 +1,213 @@
> +#!/bin/sh
> +
> +test_description=3D'git p4 metadata encoding
> +
> +This test checks that the import process handles inconsistent text
> +encoding in p4 metadata (author names, commit messages, etc) without
> +failing, and produces maximally sane output in git.'
> +
> +. ./lib-git-p4.sh
> +
> +python_target_version=3D'2'
> +
> +###############################
> +## SECTION REPEATED IN t9836 ##
> +###############################
> +
> +# Please note: this test calls "git-p4.py" rather than "git-p4", because=
 the
> +# latter references a specific path so we can't easily force it to run u=
nder
> +# the python version we need to.
> +
> +python_major_version=3D$(python -V 2>&1 | cut -c  8)
> +python_target_binary=3D$(which python$python_target_version)
> +if ! test "$python_major_version" =3D "$python_target_version" && test "=
$python_target_binary"
> +then
> +       mkdir temp_python
> +       PATH=3D"$(pwd)/temp_python:$PATH" && export PATH
> +       ln -s $python_target_binary temp_python/python
> +fi
> +
> +python_major_version=3D$(python -V 2>&1 | cut -c  8)
> +if ! test "$python_major_version" =3D "$python_target_version"
> +then
> +       skip_all=3D"skipping python$python_target_version-specific git p4=
 tests; python$python_target_version not available"
> +       test_done
> +fi
> +
> +remove_user_cache () {
> +       rm "$HOME/.gitp4-usercache.txt" || true
> +}
> +
> +test_expect_success 'start p4d' '
> +       start_p4d
> +'
> +
> +test_expect_success 'init depot' '
> +       (
> +               cd "$cli" &&
> +
> +               p4_add_user "utf8_author" "=C7=A3uthor" &&
> +               P4USER=3Dutf8_author &&
> +               touch file1 &&
> +               p4 add file1 &&
> +               p4 submit -d "first CL has some utf-8 t=C7=A3xt" &&
> +
> +               p4_add_user "latin1_author" "$(echo =C3=A6uthor |
> +                       iconv -f utf8 -t latin1)" &&
> +               P4USER=3Dlatin1_author &&
> +               touch file2 &&
> +               p4 add file2 &&
> +               p4 submit -d "$(echo second CL has some latin-1 t=C3=A6xt=
 |
> +                       iconv -f utf8 -t latin1)" &&
> +
> +               p4_add_user "cp1252_author" "$(echo =C3=A6uth=C5=93r |
> +                       iconv -f utf8 -t cp1252)" &&
> +               P4USER=3Dcp1252_author &&
> +               touch file3 &&
> +               p4 add file3 &&
> +               p4 submit -d "$(echo third CL has s=C5=93me cp-1252 t=C3=
=A6xt |
> +                 iconv -f utf8 -t cp1252)" &&
> +
> +               p4_add_user "cp850_author" "$(echo =C3=85uthor |
> +                       iconv -f utf8 -t cp850)" &&
> +               P4USER=3Dcp850_author &&
> +               touch file4 &&
> +               p4 add file4 &&
> +               p4 submit -d "$(echo fourth CL h=C3=85s some cp850 text |
> +                       iconv -f utf8 -t cp850)"
> +       )
> +'
> +
> +test_expect_success 'clone non-utf8 repo with strict encoding' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       test_must_fail git -c git-p4.metadataDecodingStrategy=3Dstrict p4=
.py clone --dest=3D"$git" //depot@all 2>err &&
> +       grep "Decoding perforce metadata failed!" err
> +'
> +
> +test_expect_success 'check utf-8 contents with passthrough strategy' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dpassthrough p4.py clone =
--dest=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               grep "some utf-8 t=C7=A3xt" actual &&
> +               grep "=C7=A3uthor" actual
> +       )
> +'
> +
> +test_expect_success 'check latin-1 contents corrupted in git with passth=
rough strategy' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dpassthrough p4.py clone =
--dest=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               badly_encoded_in_git=3D$(echo "some latin-1 t=C3=A6xt" | =
iconv -f utf8 -t latin1) &&
> +               grep "$badly_encoded_in_git" actual &&
> +               bad_author_in_git=3D"$(echo =C3=A6uthor | iconv -f utf8 -=
t latin1)" &&
> +               grep "$bad_author_in_git" actual
> +       )
> +'
> +
> +test_expect_success 'check utf-8 contents with fallback strategy' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dfallback p4.py clone --d=
est=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               grep "some utf-8 t=C7=A3xt" actual &&
> +               grep "=C7=A3uthor" actual
> +       )
> +'
> +
> +test_expect_success 'check latin-1 contents with fallback strategy' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dfallback p4.py clone --d=
est=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               grep "some latin-1 t=C3=A6xt" actual &&
> +               grep "=C3=A6uthor" actual
> +       )
> +'
> +
> +test_expect_success 'check cp-1252 contents with fallback strategy' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dfallback p4.py clone --d=
est=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               grep "s=C5=93me cp-1252 t=C3=A6xt" actual &&
> +               grep "=C3=A6uth=C5=93r" actual
> +       )
> +'
> +
> +test_expect_success 'check cp850 contents parsed with correct fallback' =
'
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dfallback -c git-p4.metad=
ataFallbackEncoding=3Dcp850 p4.py clone --dest=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               grep "h=C3=85s some cp850 text" actual &&
> +               grep "=C3=85uthor" actual
> +       )
> +'
> +
> +test_expect_success 'check cp850-only contents escaped when cp1252 is fa=
llback' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dfallback p4.py clone --d=
est=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               grep "h%8Fs some cp850 text" actual &&
> +               grep "%8Futhor" actual
> +       )
> +'
> +
> +test_expect_success 'check cp-1252 contents on later sync after clone wi=
th fallback strategy' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dfallback p4.py clone --d=
est=3D"$git" //depot@all &&
> +       (
> +               cd "$cli" &&
> +               P4USER=3Dcp1252_author &&
> +               touch file10 &&
> +               p4 add file10 &&
> +               p4 submit -d "$(echo later CL has s=C5=93me more cp-1252 =
t=C3=A6xt |
> +                       iconv -f utf8 -t cp1252)"
> +       ) &&
> +       (
> +               cd "$git" &&
> +
> +               git p4.py sync --branch=3Dmaster &&
> +
> +               git log p4/master >actual &&
> +               grep "s=C5=93me more cp-1252 t=C3=A6xt" actual &&
> +               grep "=C3=A6uth=C5=93r" actual
> +       )
> +'
> +
> +############################
> +## / END REPEATED SECTION ##
> +############################
> +
> +test_expect_success 'passthrough (latin-1 contents corrupted in git) is =
the default with python2' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dpassthrough p4.py clone =
--dest=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               badly_encoded_in_git=3D$(echo "some latin-1 t=C3=A6xt" | =
iconv -f utf8 -t latin1) &&
> +               grep "$badly_encoded_in_git" actual
> +       )
> +'
> +
> +test_done
> diff --git a/t/t9836-git-p4-metadata-encoding-python3.sh b/t/t9836-git-p4=
-metadata-encoding-python3.sh
> new file mode 100755
> index 00000000000..63350dc4b5c
> --- /dev/null
> +++ b/t/t9836-git-p4-metadata-encoding-python3.sh
> @@ -0,0 +1,214 @@
> +#!/bin/sh
> +
> +test_description=3D'git p4 metadata encoding
> +
> +This test checks that the import process handles inconsistent text
> +encoding in p4 metadata (author names, commit messages, etc) without
> +failing, and produces maximally sane output in git.'
> +
> +. ./lib-git-p4.sh
> +
> +python_target_version=3D'3'
> +
> +###############################
> +## SECTION REPEATED IN t9835 ##
> +###############################
> +
> +# Please note: this test calls "git-p4.py" rather than "git-p4", because=
 the
> +# latter references a specific path so we can't easily force it to run u=
nder
> +# the python version we need to.
> +
> +python_major_version=3D$(python -V 2>&1 | cut -c  8)
> +python_target_binary=3D$(which python$python_target_version)
> +if ! test "$python_major_version" =3D "$python_target_version" && test "=
$python_target_binary"
> +then
> +       mkdir temp_python
> +       PATH=3D"$(pwd)/temp_python:$PATH" && export PATH
> +       ln -s $python_target_binary temp_python/python
> +fi
> +
> +python_major_version=3D$(python -V 2>&1 | cut -c  8)
> +if ! test "$python_major_version" =3D "$python_target_version"
> +then
> +       skip_all=3D"skipping python$python_target_version-specific git p4=
 tests; python$python_target_version not available"
> +       test_done
> +fi
> +
> +remove_user_cache () {
> +       rm "$HOME/.gitp4-usercache.txt" || true
> +}
> +
> +test_expect_success 'start p4d' '
> +       start_p4d
> +'
> +
> +test_expect_success 'init depot' '
> +       (
> +               cd "$cli" &&
> +
> +               p4_add_user "utf8_author" "=C7=A3uthor" &&
> +               P4USER=3Dutf8_author &&
> +               touch file1 &&
> +               p4 add file1 &&
> +               p4 submit -d "first CL has some utf-8 t=C7=A3xt" &&
> +
> +               p4_add_user "latin1_author" "$(echo =C3=A6uthor |
> +                       iconv -f utf8 -t latin1)" &&
> +               P4USER=3Dlatin1_author &&
> +               touch file2 &&
> +               p4 add file2 &&
> +               p4 submit -d "$(echo second CL has some latin-1 t=C3=A6xt=
 |
> +                       iconv -f utf8 -t latin1)" &&
> +
> +               p4_add_user "cp1252_author" "$(echo =C3=A6uth=C5=93r |
> +                       iconv -f utf8 -t cp1252)" &&
> +               P4USER=3Dcp1252_author &&
> +               touch file3 &&
> +               p4 add file3 &&
> +               p4 submit -d "$(echo third CL has s=C5=93me cp-1252 t=C3=
=A6xt |
> +                 iconv -f utf8 -t cp1252)" &&
> +
> +               p4_add_user "cp850_author" "$(echo =C3=85uthor |
> +                       iconv -f utf8 -t cp850)" &&
> +               P4USER=3Dcp850_author &&
> +               touch file4 &&
> +               p4 add file4 &&
> +               p4 submit -d "$(echo fourth CL h=C3=85s some cp850 text |
> +                       iconv -f utf8 -t cp850)"
> +       )
> +'
> +
> +test_expect_success 'clone non-utf8 repo with strict encoding' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       test_must_fail git -c git-p4.metadataDecodingStrategy=3Dstrict p4=
.py clone --dest=3D"$git" //depot@all 2>err &&
> +       grep "Decoding perforce metadata failed!" err
> +'
> +
> +test_expect_success 'check utf-8 contents with passthrough strategy' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dpassthrough p4.py clone =
--dest=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               grep "some utf-8 t=C7=A3xt" actual &&
> +               grep "=C7=A3uthor" actual
> +       )
> +'
> +
> +test_expect_success 'check latin-1 contents corrupted in git with passth=
rough strategy' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dpassthrough p4.py clone =
--dest=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               badly_encoded_in_git=3D$(echo "some latin-1 t=C3=A6xt" | =
iconv -f utf8 -t latin1) &&
> +               grep "$badly_encoded_in_git" actual &&
> +               bad_author_in_git=3D"$(echo =C3=A6uthor | iconv -f utf8 -=
t latin1)" &&
> +               grep "$bad_author_in_git" actual
> +       )
> +'
> +
> +test_expect_success 'check utf-8 contents with fallback strategy' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dfallback p4.py clone --d=
est=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               grep "some utf-8 t=C7=A3xt" actual &&
> +               grep "=C7=A3uthor" actual
> +       )
> +'
> +
> +test_expect_success 'check latin-1 contents with fallback strategy' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dfallback p4.py clone --d=
est=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               grep "some latin-1 t=C3=A6xt" actual &&
> +               grep "=C3=A6uthor" actual
> +       )
> +'
> +
> +test_expect_success 'check cp-1252 contents with fallback strategy' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dfallback p4.py clone --d=
est=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               grep "s=C5=93me cp-1252 t=C3=A6xt" actual &&
> +               grep "=C3=A6uth=C5=93r" actual
> +       )
> +'
> +
> +test_expect_success 'check cp850 contents parsed with correct fallback' =
'
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dfallback -c git-p4.metad=
ataFallbackEncoding=3Dcp850 p4.py clone --dest=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               grep "h=C3=85s some cp850 text" actual &&
> +               grep "=C3=85uthor" actual
> +       )
> +'
> +
> +test_expect_success 'check cp850-only contents escaped when cp1252 is fa=
llback' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dfallback p4.py clone --d=
est=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               grep "h%8Fs some cp850 text" actual &&
> +               grep "%8Futhor" actual
> +       )
> +'
> +
> +test_expect_success 'check cp-1252 contents on later sync after clone wi=
th fallback strategy' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git -c git-p4.metadataDecodingStrategy=3Dfallback p4.py clone --d=
est=3D"$git" //depot@all &&
> +       (
> +               cd "$cli" &&
> +               P4USER=3Dcp1252_author &&
> +               touch file10 &&
> +               p4 add file10 &&
> +               p4 submit -d "$(echo later CL has s=C5=93me more cp-1252 =
t=C3=A6xt |
> +                       iconv -f utf8 -t cp1252)"
> +       ) &&
> +       (
> +               cd "$git" &&
> +
> +               git p4.py sync --branch=3Dmaster &&
> +
> +               git log p4/master >actual &&
> +               grep "s=C5=93me more cp-1252 t=C3=A6xt" actual &&
> +               grep "=C3=A6uth=C5=93r" actual
> +       )
> +'
> +
> +############################
> +## / END REPEATED SECTION ##
> +############################
> +
> +
> +test_expect_success 'fallback (both utf-8 and cp-1252 contents handled) =
is the default with python3' '
> +       test_when_finished cleanup_git &&
> +       test_when_finished remove_user_cache &&
> +       git p4.py clone --dest=3D"$git" //depot@all &&
> +       (
> +               cd "$git" &&
> +               git log >actual &&
> +               grep "s=C5=93me cp-1252 t=C3=A6xt" actual &&
> +               grep "=C3=A6uth=C5=93r" actual
> +       )
> +'
> +
> +test_done
>
> base-commit: 11cfe552610386954886543f5de87dcc49ad5735
> --
> gitgitgadget
