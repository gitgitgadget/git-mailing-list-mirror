Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8141F461
	for <e@80x24.org>; Fri,  5 Jul 2019 16:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfGEQZr (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 12:25:47 -0400
Received: from mout.web.de ([212.227.17.11]:48629 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfGEQZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 12:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562343945;
        bh=84pk8LL9kCeBpXQw7dRHULaNF1ums8lsIRCj68XKcPk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=foD4bsioQ880Wmp8fhxiVZvzC8LB4hWsUmMFDcKrybeLdg1EYTs9hllxyfiMvP6dW
         a5V6M1aQC66duq8w5Ly99XB3eqp8965Y82jgpnVGpCuS5OsEsXWt8V2lOD771w+Evv
         X7Ho4ME9lTtWgpWHT+mTaKlA8qhOtxAPj1T6kN3Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8iH2-1hotcK3i6W-00CAlU; Fri, 05
 Jul 2019 18:25:44 +0200
Date:   Fri, 5 Jul 2019 18:25:44 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Mateusz Loskot <mateusz@loskot.net>
Cc:     git@vger.kernel.org
Subject: Re: Handling text files encoded in little-endian UTF-16 with BOM
Message-ID: <20190705162544.gckigv4cbr4k6zpz@tb-raspi4>
References: <CABUeae_90xG7avh1yt2_X78pmpYUvLtXAZ2Kd9A=FpcEayvi-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABUeae_90xG7avh1yt2_X78pmpYUvLtXAZ2Kd9A=FpcEayvi-Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Per7XyykCOfz9B8jskSsPXhKW9XgQ0ZNtkUk68cB/ku4vmNesCB
 ZYC3IDQtCOjj4ZqHcIhnkXDKwkq9Ut2CCMnmPF2gv+hVvqh2WDgUFJFFCMCPj+WvgKmSKF0
 TfJ2YmIBFWSHj1PZC3DFMGy4lfGQHYoPD5PPVQr7vsq/+l9Iy+OG11IJ9ss84RIx2Ol8uEs
 wPwQosffqg05FIDL5/IQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PucWbf2py+s=:X6dRC9TtqFvD9+9tJtrmQT
 6Y6xcP5fCYiJ1GtcC9b0cmixcczhrP+HmZ+84jW83GKfXOUDxMBfIT6smOmQosQ35toudLvZG
 QuRKivPaAD6ZxhGETwyr3RyMAQdDYckSLPB8fNV0IJA9Qe5J2P3WwUbfBYa/xronSy9qFLJpk
 4vDM6gm5ypQczU60AJdHkj4xr/0K9QQNt+G/wys07LBRVcED5oAGZ6+/KXbrVwx5ymoZGDBnr
 WALg5wgZX24oM0vKmGwvxcmi0vkyC337tiLic2B+3iMawq70c6+G2v1x+qWUDchdtgEctfToi
 DBQ+kvp2FvVqyraJP+VvbRnuy1dOe7q2KXHxjR/wUKnEXTEhX7SaMa1/Al/MM5dFijCgJS6pg
 TvLeNelR3PUf1L0dwupZki5KLkVho+eUyWZV1IUP7xTh0fzeBZI2QT1PUY4rTSIIXYjVvC6DT
 unOBIDthbHA2BfBszbXrY32evfBQDeOYcX+wm5f/EnUpZD16e//BmAx5Zeye9xwZnNg0Q/CFW
 Wy5Ap21cQMfRN1+LUUe4HuEGAtDXb+NBFVerOU5BJFvnpFIR8n2+pqlwkIx93102OJGz8lD5f
 yp9DNWFn3DsE09jJSNgIw5bXwtfg2qytPYM3ufrNcnPuEzb22ZdgcfRQL53cPOvJSeKz4gHnv
 Kg58eXkTNrO8L9pYRG4fBG4AHRNwYKnsGsX0TUzrvUGbQYjkPPC/Tx5Xm3Ec0HGpKD9sisGcx
 CBFEEwlqXHyHzIeCX/U9v6TSISmz3c+yvVyVPMse7XRW8kCW68S4G6LlTMUEYMPZW+aqPjkGa
 tTs/ru26OajzUA1n+jATJvll9t4YSOpo+cj+zBdBwA7mhf/6dIUyECmMVzXCFl6Gpr6n+azFn
 AiMciAbJxdxxKxeHUZ4th/awj51kXkKSJVCjY9yIhwYwrhtjnsV0xWabvywlnLm6FFjtLko4Q
 ll4XEyGkVPZycLXgA/x+HyVV5ZW/xrJyXON3Yyzyhe+jP7pz7amu47aqWQo6xG9pMoqgmu0Pb
 yVmQ5hR7Y7InLikpCjfZDcQUISmgQaQ9EJk4hj+eVkp4pcKx44+jhNqo4j3Ktm+xOA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 05, 2019 at 01:35:13PM +0200, Mateusz Loskot wrote:
> Hi,
>
> Using git version 2.22.0.windows.1
>
> I have a repository with number of .txt files encoded in
> little-endian UTF-16 with BOM.
>
> What are the best practice and recommended configuration to
> manage such files with Git to avoid unexpected re-encoding to
> UTF-8 or others?
>
> Currently, there is .gitattriuts with entries like
>
>    resource/*.txt   working-tree-encoding=3DUTF-16LE-BOM -text
>
> Despite that some of team members have noticed that the files
> occacionally get re-encoded to UTF-8. It is unknow what are
> actual steps leading to that. BTW, there a few Git clients
> in use: git in Git Bash, VSCode, Fork.

If possible, I don't want to comment on this kind of
"sometimes something happens something on someones computer" thing.
A little bit more information could be helpful.

>
> What bothers me in the .gitattributes is this `-text` attribute.
>
> Is the use of `working-tree-encoding` and `-text` together a
> valid combination at all?

Yes, it means that the content re-encoded between the repo and the working=
 tree,
(that is what you want)
And the "-text" means "leave the line endings" (LF or CRLF) as is, don't c=
onvert them.

In that sense you can call that a legal combination, but may be not a reco=
mmended one.

>
> The documentation at https://git-scm.com/docs/gitattributes
> does not seem to touch on that.
>
> I'll appreciate any suggestions on those UTF-16LE-BOM files.
>

My suggestion would be to use the "text" attribute:
  resource/*.txt   working-tree-encoding=3DUTF-16LE-BOM text

And depending on your application: Do the resource files need a special li=
ne ending ?
The use either
  resource/*.txt   working-tree-encoding=3DUTF-16LE-BOM text eol=3DLF
or
  resource/*.txt   working-tree-encoding=3DUTF-16LE-BOM text eol=3DCRLF

I hope that helps a little bit.

> Best regards,
> --
> Mateusz Loskot, http://mateusz.loskot.net
