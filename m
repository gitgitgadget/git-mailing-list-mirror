Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 448E11F424
	for <e@80x24.org>; Fri,  6 Apr 2018 12:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeDFMBF (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 08:01:05 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33071 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeDFMBF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 08:01:05 -0400
Received: by mail-qk0-f181.google.com with SMTP id d206so833604qkb.0
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 05:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ftfl.ca; s=google;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=gf0OCUCnNTsekmGH9rJtRCCAKBsQ8Ag6uL+smzXSAJQ=;
        b=ZlTb+n6dUIjVNiv0MikcuBFf3i+cxsz+uBThzwTyRXN0ga5XH0uNwiHsODt0fBLKV4
         rJ3cOTQXSw635sFzTbYDW0kr9xFzMWZ3uHvSe85k9ePvqFJIhc63h7567XzzZGm7StDQ
         PvsfUqHgFB7WYPVJclmVKRnNHL8KEzJqv4rL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :mime-version;
        bh=gf0OCUCnNTsekmGH9rJtRCCAKBsQ8Ag6uL+smzXSAJQ=;
        b=J9CszajFJTCxBKqqZUXS0b0mTsBWoTz/gjNSaSNW2EhwcVgxHrjVtNwiviPfgGoBF/
         vXD+zg8nPnPH95AmMUiT37DT11iBv7mu/JPfwTr0amJKWQ95d6Z1emSSoEsLiinYhArx
         wE5HO9yabHbG2uKvVyc3RjNon/Rxsoxplo/XVwgTwfwCUCQoA2dNhfvNqpmtwfA8vKgF
         xJC2sg1APe/6J21nTedXiE6eeg9lRgVl2UORRyz87Oea3kZNIC8rFx4SXKOtj7e55+V9
         eZhctjMaTXhdR6wn9iV3/rRUFt7yj+enl+6ulSBL6D5h30zdoP2eYXHe43EWiyi7nrlk
         kzTw==
X-Gm-Message-State: ALQs6tAbwGBfQQUBHcnFlgvtnxM26RaP8g/KdArra7CljAE/8piV9+Qn
        AxuzhMZowSWVdCy7fOk6dMtirg==
X-Google-Smtp-Source: AIpwx4/JKGy9DoL3ElC/U5/zJvn7HWy2L0uVGlEGlYCM417Z9eZzSfV5h36sdFBcLPn2VJS1LBW6Kg==
X-Received: by 10.55.172.9 with SMTP id e9mr13995191qkm.112.1523016064288;
        Fri, 06 Apr 2018 05:01:04 -0700 (PDT)
Received: from phe.ftfl.ca.ftfl.ca (hlfxns017vw-47-55-140-73.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.140.73])
        by smtp.gmail.com with ESMTPSA id r79sm659498qkl.35.2018.04.06.05.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 05:01:03 -0700 (PDT)
From:   Joseph Mingrone <jrm@ftfl.ca>
To:     git@vger.kernel.org
Cc:     garga@FreeBSD.org
Subject: git 2.17.0: uninitialized value $rec in scalar chomp at ...Git.pm line 557
Date:   Fri, 06 Apr 2018 09:01:01 -0300
Message-ID: <86h8oobl36.fsf@phe.ftfl.ca>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (berkeley-unix)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hello,

After upgrading to version 2.17.0, this message appears repeatedly when
running `git svn rebase`:

Use of uninitialized value $rec in scalar chomp at /usr/local/lib/perl5/site_perl/Git.pm line 557, <$fh> chunk 1.

The value of chunk varies.  For example the message above may end with
'...<$fh> chunk 5.'  This is with the FreeBSD packages git-2.17.0 and
perl 5.26.1.

Regards,

J.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAEBCgB9FiEEVbCTpybDiFVxIrrVNqQMg7DW754FAlrHYX1fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDU1
QjA5M0E3MjZDMzg4NTU3MTIyQkFENTM2QTQwQzgzQjBENkVGOUUACgkQNqQMg7DW
757Sfg/+L9AwidWr9pAH7aRaSuBqDDueUfT1xz8OTHjRbyHvm0NJyDec1YXMPCPH
OZHmW8Hx6MuTM0ei6dsBZU4RaeiRCCVEJfGcXVT1kAjkVLYWucwKscbbrehOvOuW
nRKWL3aJoIMfV1pF+cmhVljWQfki2AD41oNozzCbc5nyjATTK/ea4855XonEugYg
xnMcx1hG1kMIEihlYKB1VHrZrxOxxDkqVPv/vuf2p3NVX4IuuPYOr60BO9tdzTMp
jiYE4+PO94CGyyexVV8+3QWcDc5cMf2zZi5+lYsnHuSyfG1+UpBEbse/VFprE/og
KkYmPJIAV1GjjyTaEb/Zw031VHJnETzrwr4S6aF5iWjztzAuSrCdalH0sMBRHb4W
W11I6u5t/tCCRNu7MyFUdtFlVEju/OtYpOE1sqm61HmufwAs3reuwgzyMOJdNMTD
k998knAHBByYDW1oCkvUe6xCLM9JfQPY4VPowa20xscuss5jO1xvLT/KlWFMHJOB
Htl75x4kfjWyEA60Hi/kaFbW/IJkkN6/rMuBclHpBL4MtGXeAfbjE2V4WkICtg+X
2rHfDHmrZnNNlm70IDldR+tbn+mM0Dv8wvNgeiE4GMXaLl15BtB7PyMpa/xhJ7+D
dBW+imC5T1e5A8OVP66CexhKGsegtbddvJzEVoFAwH8L1zTvX7I=
=KfDo
-----END PGP SIGNATURE-----
--=-=-=--
