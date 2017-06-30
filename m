Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E85E20209
	for <e@80x24.org>; Fri, 30 Jun 2017 08:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbdF3I1U (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 04:27:20 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37525 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdF3I0M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 04:26:12 -0400
Received: by mail-wm0-f42.google.com with SMTP id i127so38158995wma.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GpLWnbuAXDkxuNT3wo3JntfOj3+EYj2qaGDVXruGsbs=;
        b=s9FtqCaBA2Cwt7Q3UQQ5HjP/pw1oYL/owtaongdOgT6pr0YDgGxQhwyEysrxhYhb//
         8F/OTcH2DwILNT75qgMnbUeI+VbhltWjPnJV6uvvSZj/SfOq57CT0oujILgmCfnLLCGG
         t6/ekYHGbJ0jq/k5NCudayydcefqN8lvNtMyyH7nJHuPBtQpxWMNeMwpx4fF+c8vqzMn
         3djseueZMk1hR1+x/O+VkJxv0UksMKhWg05s25NiHY4SVp/n6WpLPmQUOkR8Bz2DS8L7
         6/OhqtFTGzsAgzTZf6oigHSb+sct4PNfR4ns5uQax7441H7hAhaE1tHaiyuLGtrx3Dos
         yx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GpLWnbuAXDkxuNT3wo3JntfOj3+EYj2qaGDVXruGsbs=;
        b=h3Q7YQBdeEnZ658S4wpYnHrH7CGvoqelcOR075xTCQwhBsmfa/00M9jgTmwQklz2sP
         n4St5GYRrcUI9iNSAVz+d9YD2olPnawGaMiJu8K2PEtbBh+qQXXEGpYGCiowAHa7dtCY
         dkctQV6zBbGP7SgNWjiLudehhdUvz3zRDvHY1YSodEpj/t0+27U1vchfccRiYpfFzbWZ
         mdsVi8+c7fJNN7l8UgCDkzIcBxthJiAPWuK5NA0JZJRmKBs18pUHU71kdsAlfKAKIuCJ
         MkYLkoHTEzfIfQGb6t/e8MYCVDTGMEevNRgrPAaym8KAswRuDd1HFt9PP+Dl50tLaKoF
         PdSQ==
X-Gm-Message-State: AIVw1116S5qju1oqtJPOcLZ+c+Ri0ya3LDl+lHMwfsAAtqhUsjUR0IAc
        o87C2090PCG/zr4gGfk=
X-Received: by 10.28.149.209 with SMTP id x200mr5417734wmd.91.1498811170444;
        Fri, 30 Jun 2017 01:26:10 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4C89.dip0.t-ipconnect.de. [93.219.76.137])
        by smtp.gmail.com with ESMTPSA id l14sm5188293wrb.19.2017.06.30.01.26.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 01:26:09 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170629224659.25677-1-miguel.torroja@gmail.com>
Date:   Fri, 30 Jun 2017 10:26:09 +0200
Cc:     Luke Diamand <luke@diamand.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <41BF267D-5F4D-4031-B9D4-15DB263D35D9@gmail.com>
References: <CAE5ih7-x45MD1H6Ahr5oCVtTjgbBkeP4GbKCGB-Cwk6BSQwTcw@mail.gmail.com> <20170629224659.25677-1-miguel.torroja@gmail.com>
To:     miguel torroja <miguel.torroja@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 30 Jun 2017, at 00:46, miguel torroja <miguel.torroja@gmail.com> =
wrote:
>=20
> The option -G of p4 (python marshal output) gives more context about =
the
> data being output. That's useful when using the command "change -o" as
> we can distinguish between warning/error line and real change =
description.
>=20
> Some p4 triggers in the server side generate some warnings when
> executed. Unfortunately those messages are mixed with the output of
> "p4 change -o". Those extra warning lines are reported as =
{'code':'info'}
> in python marshal output (-G). The real change output is reported as
> {'code':'stat'}
>=20
> A new test has been created to t9807-git-p4-submit.sh adding a p4 =
trigger
> that outputs extra lines with "p4 change -o" and "p4 changes"
>=20
> Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> git-p4.py                | 85 =
++++++++++++++++++++++++++++++++----------------
> t/t9807-git-p4-submit.sh | 27 +++++++++++++++
> 2 files changed, 84 insertions(+), 28 deletions(-)
>=20
> diff --git a/git-p4.py b/git-p4.py
> index 8d151da91..61dc045f3 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -879,8 +879,12 @@ def p4ChangesForPaths(depotPaths, changeRange, =
requestedBlockSize):
>             cmd +=3D ["%s...@%s" % (p, revisionRange)]
>=20
>         # Insert changes in chronological order
> -        for line in reversed(p4_read_pipe_lines(cmd)):
> -            changes.add(int(line.split(" ")[1]))
> +        for entry in reversed(p4CmdList(cmd)):
> +            if entry.has_key('p4ExitCode'):
> +                die('Error retrieving changes descriptions =
({})'.format(entry['p4ExitCode']))
> +            if not entry.has_key('change'):
> +                continue
> +            changes.add(int(entry['change']))
>=20
>         if not block_size:
>             break
> @@ -1526,37 +1530,62 @@ class P4Submit(Command, P4UserMap):
>=20
>         [upstream, settings] =3D findUpstreamBranchPoint()
>=20
> -        template =3D ""
> +        template =3D """\
> +# A Perforce Change Specification.
> +#
> +#  Change:      The change number. 'new' on a new changelist.
> +#  Date:        The date this specification was last modified.
> +#  Client:      The client on which the changelist was created.  =
Read-only.
> +#  User:        The user who created the changelist.
> +#  Status:      Either 'pending' or 'submitted'. Read-only.
> +#  Type:        Either 'public' or 'restricted'. Default is 'public'.
> +#  Description: Comments about the changelist.  Required.
> +#  Jobs:        What opened jobs are to be closed by this changelist.
> +#               You may delete jobs from this list.  (New changelists =
only.)
> +#  Files:       What opened files from the default changelist are to =
be added
> +#               to this changelist.  You may delete files from this =
list.
> +#               (New changelists only.)
> +"""
> +        files_list =3D []
>         inFilesSection =3D False
> +        change_entry =3D None
>         args =3D ['change', '-o']
>         if changelist:
>             args.append(str(changelist))
> -
> -        for line in p4_read_pipe_lines(args):
> -            if line.endswith("\r\n"):
> -                line =3D line[:-2] + "\n"
> -            if inFilesSection:
> -                if line.startswith("\t"):
> -                    # path starts and ends with a tab
> -                    path =3D line[1:]
> -                    lastTab =3D path.rfind("\t")
> -                    if lastTab !=3D -1:
> -                        path =3D path[:lastTab]
> -                        if settings.has_key('depot-paths'):
> -                            if not [p for p in =
settings['depot-paths']
> -                                    if p4PathStartsWith(path, p)]:
> -                                continue
> -                        else:
> -                            if not p4PathStartsWith(path, =
self.depotPath):
> -                                continue
> +        for entry in p4CmdList(args):
> +            if not entry.has_key('code'):
> +                continue
> +            if entry['code'] =3D=3D 'stat':
> +                change_entry =3D entry
> +                break
> +        if not change_entry:
> +            die('Failed to decode output of p4 change -o')
> +        for key, value in change_entry.iteritems():
> +            if key.startswith('File'):
> +                if settings.has_key('depot-paths'):
> +                    if not [p for p in settings['depot-paths']
> +                            if p4PathStartsWith(value, p)]:
> +                        continue
>                 else:
> -                    inFilesSection =3D False
> -            else:
> -                if line.startswith("Files:"):
> -                    inFilesSection =3D True
> -
> -            template +=3D line
> -
> +                    if not p4PathStartsWith(value, self.depotPath):
> +                        continue
> +                files_list.append(value)
> +                continue
> +        # Output in the order expected by prepareLogMessage
> +        for key in =
['Change','Client','User','Status','Description','Jobs']:
> +            if not change_entry.has_key(key):
> +                continue
> +            template +=3D '\n'
> +            template +=3D key + ':'
> +            if key =3D=3D 'Description':
> +                template +=3D '\n'
> +            for field_line in change_entry[key].splitlines():
> +                template +=3D '\t'+field_line+'\n'
> +        if len(files_list) > 0:
> +            template +=3D '\n'
> +            template +=3D 'Files:\n'
> +        for path in files_list:
> +            template +=3D '\t'+path+'\n'
>         return template
>=20
>     def edit_template(self, template_file):
> diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
> index 3457d5db6..4962b6862 100755
> --- a/t/t9807-git-p4-submit.sh
> +++ b/t/t9807-git-p4-submit.sh
> @@ -409,6 +409,33 @@ test_expect_success 'description with Jobs =
section and bogus following text' '
> 	)
> '
>=20

I have never worked with p4 triggers and that might be
the reason why I don't understand your test case.
Maybe you can help me?

> +test_expect_success 'description with extra lines from verbose p4 =
trigger' '
> +	test_when_finished cleanup_git &&
> +	git p4 clone --dest=3D"$git" //depot &&
> +	(
> +		p4 triggers -i <<-EOF
> +		Triggers: p4triggertest-command command pre-user-change =
"echo verbose trigger"
> +		EOF
> +	) &&

You clone the test repo and install a trigger.

> +	(
> +		cd "$git" &&
> +		git config git-p4.skipSubmitEdit true &&
> +		echo file20 >file20 &&
> +		git add file20 &&
> +		git commit -m file20 &&
> +		git p4 submit
> +	) &&

You make a new commit. This should run the "echo verbose trigger", =
right?

> +	(
> +		p4 triggers -i <<-EOF
> +		Triggers:
> +		EOF
> +	) &&

You delete the trigger.

> +	(
> +		cd "$cli" &&
> +		test_path_is_file file20
> +	)

You check that the file20 is available in P4.


What would happen if I run this test case without your patch?
Wouldn't it pass just fine?
Wouldn't we need to check that no warning/error is in the
real change description?

Thanks,
Lars=
