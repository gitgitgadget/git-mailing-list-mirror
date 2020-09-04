Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E891AC43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 14:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF452206B7
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 14:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Fm3LZwkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgIDOIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:08:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:43225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730559AbgIDOHx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 10:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599228457;
        bh=jva4REYkVC0cRzMOo617t5TWk/dZGER1Wgne3+hxs+U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Fm3LZwkGoLyIyDo4kFLRkCVtvE0hmUv/ignYXACMwsI72WZ0TeO3Q24IYyjyTv7D+
         Tq6XgeT+S438Ujzy999A3cd3BEtg/33mQ1n/W8IOWcJlo2isuOoBHeIfQnQLzjF+wF
         T1bMZxJltPUYtp8qNU44xcY4fYhlmi+R6H+OSgYM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.212.11]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMyf-1jsQP22kF7-00MI3h; Fri, 04
 Sep 2020 16:07:37 +0200
Date:   Fri, 4 Sep 2020 07:43:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Victor Toni <victor.toni@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Aborting git rebase --edit-todo
In-Reply-To: <CAG0OSgdT+ZCT0dN29A89XhWi65SFepwyGA0SoS22TYGrvNnWqw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009040742380.56@tvgsbejvaqbjf.bet>
References: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com> <xmqqa6y6ah8h.fsf@gitster.c.googlers.com> <CAG0OSgcUi6sKJQmUEd4-Lu5qAiQqKk7X7aSRvRtcBWkcKj4f1g@mail.gmail.com> <xmqqtuwe8t5s.fsf@gitster.c.googlers.com>
 <CAG0OSgdT+ZCT0dN29A89XhWi65SFepwyGA0SoS22TYGrvNnWqw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VLvchYAZajoOy2a5iMy0YK3sjgtdj10/RyimBld0O63mBcBzljJ
 P2/unMaIK3LgXa6iz8DkMoG7+zJEb5RFa170Qze3G30RzoVNFKI4X15atkBkZW1CUC85NjU
 fobi4lsb4c/+HYC3o5bSPir2anTq9MzuOexb27mSaDiRk0fJUJ+mHDbaZvL65t1965/K11D
 JQ6mlDGaxAYU33YdWbedA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5qsOwZBoDr0=:0mSe1G9NfI6GdR7Tgouhsx
 GEW4QIYxJc72JrlzSHToS6khtE4cI+mjtdFGsd3uGvUAD9i1cihtpJogaCm+Xx1GWnP+htvQW
 lqM9iX/DGrd/AlXJ96kGVtT3aTM6uO2XT8R8rnBNt4MRks+UDnoLdiuIMQyTYlPafKDWVnXpv
 fO7iPJ+gB7YffRUABT2VuXU++nGDdNxi/T7Y0W9X4QIdnlNcy0oesYFssWbfrVbiayYOagkwr
 QfzUHc4cE5zYJXJh81xQtbHIhd1WyZVAAJXDiWRPZaNkKsSd8fWbyml8gMHJbkPWd8rVV17dK
 s8CefG/U6zH74BsQV+/0a+yY6gWrqOyceyXW3ey0HQoPw6jvZy/vkOvKTwVl//4yxyxTu/rQD
 OzHud3usltCpqhdmod/n7F1KiRR6rtNysBmLatf+Ju1+AVHP+lU2iM4EpTUnSDGLtAE+yvT/3
 cYfCWFx/M9EYNEFBFBtaiJ7pY/6iiKYZhL80xxcNEMpPL9Hgv/uEHy2wevSUfu724hHZlrlWS
 2bsYgZtW4oPaQCUkqXsntt76qgWFoESOQSroDOkHawmt6jE+zpf/e6+7hq4Gy0re+AAlZPqIs
 GileQbPXMaPQF+urxCknba6ZjJf+9voVb06zRFdV6/buVPNYaqoWCo6jG2Pf+Xeyqy90tt5No
 8vf2kT+BBdoBiM8ARvPXnoLA+LHcb2kg/OusacJITjE5+DMYN9yX9HOG7lvRVIWg8lKy13nut
 FFGV5OQGjGisbuQi+ENiVElBWFNlOOsgi+yo73zfVK+8Qh4MPJDwZ6W0ra35m6/cALJR6P1FW
 D5OMWGHdh7Z2+zPX+daXJ7bmBSp46islAPj5wtpr49FhfO95Y+ERPlN07BCw8vK23QjcpqopB
 FBItVGJP19x9Uo9PjEMr9oTJ71Tdcu6LhcLCvLKYZjcDf1jMQ3y3SUSewdkGSRKgz1ScMatoL
 HEp6ZnI2y1EUql1jY8ybNxiQiacU7tUvLiXMn+kJP8uX6i087CDz+ejzetYH/+gZY+XKokLWr
 6YQMe531K+QPn8yKLPm3KDMgrRSqUMZ81s7JiUGJyd3JiuHoWJt3MbqenO0HNvRWYdUIv967M
 y2efA4XowTb4JOfjyzvdvLUKZ0D8dzDMaQNYjO15jOX5pqgaFprLdCKFn7PzJLJNfSIyATUbi
 mxDZm101IaeYxH8NNX3+U6k+3Pfid96XnIhUmHir+CKsL9nHPqTTpjiyRPfCzaHZNIpXO8pwM
 MLHlu2DcfZ2hVQXV/+LIuyaBiVZ0rLWblPOfP2g==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victor,

On Thu, 3 Sep 2020, Victor Toni wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> >
> > Victor Toni <victor.toni@gmail.com> writes:
> >
> > >> I think the implementor chose the first interpretation.  The "drop"
> > >> insn is a relatively recent invention, and back when it was missing
> > >> from the vocabulary, I do not think it was possible to say " discar=
d
> > >> all the rest" without emptying the todo list, so that design is
> > >> understandable.
> > >>
> > >> Now we have the "drop" verb, the latter interpretation becomes
> > >> possible without making it impossible for the user to express the
> > >> former.  It might be a good idea to
> > >>
> > >>  (1) save away the original before allowing --edit-todo to edit,
> > >>
> > >>  (2) open the editor, and
> > >>
> > >>  (3) when getting an empty buffer back, go back to step (2) using
> > >>      the back-up made in step (1).
> > >>
> > >> Either way, the todo list editor buffer can have additional comment
> > >> instructing what happens when the buffer is emptied.
> > >>
> > > Personally I would like to see your approach (1,2,3) implemented
> > > because it is not destructive. If the user wants to achieve somethin=
g
> > > different he can retry.
> >
> > Obviously I agree that the approach would be nicer than the status
> > quo.  It would not be as trivial as a microproject, but would be a
> > good bite-sized starter-task for those aspiring developers who want
> > to dip their toes in the water to start hacking on the codebase ;-)
> >
> Nice try ;) Speaking of toes ... I'm currently involved in another
> project from tip to toe.
> I would like to come back to your offer sometime next year when I've
> completed the other one.

Sure. I expect this project to wait quite patiently for you to come back
next year ;-)

Ciao,
Dscho

> Especially since I'd have to polish up my buried C skills... C didn't
> get GC lately, did it? ;)
>
