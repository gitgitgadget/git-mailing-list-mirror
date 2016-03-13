From: Eric Engestrom <eric@engestrom.ch>
Subject: Re: [PATCH] fetch: show reference pointed by new tags
Date: Sun, 13 Mar 2016 15:38:02 +0000
Message-ID: <20160313153802.GG30298@engestrom.ch>
References: <1457303694-16153-1-git-send-email-eric@engestrom.ch>
 <xmqq60wzta2s.fsf@gitster.mtv.corp.google.com>
 <xmqqwppfrtai.fsf@gitster.mtv.corp.google.com>
 <xmqqd1r5mw4p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 16:38:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1af85r-0004CC-Fw
	for gcvg-git-2@plane.gmane.org; Sun, 13 Mar 2016 16:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbcCMPiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Mar 2016 11:38:08 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34797 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbcCMPiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2016 11:38:05 -0400
Received: by mail-wm0-f48.google.com with SMTP id p65so72979632wmp.1
        for <git@vger.kernel.org>; Sun, 13 Mar 2016 08:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VZXU/3ucAak5mVSgPSkDlL6wiP2gbdxWPi/avfv8FbA=;
        b=aAjBKDejpZfdCMuBgxrgyCvsIUZ2D3mPpDfrYuJDbCvZ8v+kVc5I5QLmkRwzz0R9v3
         SGfWhMuifKghu48romABlAvxxThCSDQl3BKfYsqlmZL/W4ZL/JupPUWYskUR0QZe23UY
         jF7i4s4LrEPUBxcKOV8TkiIkTR2vCRA9WFk1AqKHTRlMxSb/TKOuTvs5LlhJxR69dImu
         C2Fx3T7kQ9bcy6MR0FUU5IU/j7qwP7Bc03l/ag5hWQc8xKBWVCNwZ+AUDiI6no2lLWF1
         8y75ZMPj+mO54maRaW6QxSKy8MAncfjsDiWTn5YUqEb1nLzzUmkKVsrrYjxbH5tHRgNs
         lKBg==
X-Gm-Message-State: AD7BkJKfCg2/QbGTZ90G19bExxFxv+dKhSvhMoe3BmP8O0S+l9xvJ85qg/jpmQzyJfnZeA==
X-Received: by 10.194.114.166 with SMTP id jh6mr19822218wjb.39.1457883483920;
        Sun, 13 Mar 2016 08:38:03 -0700 (PDT)
Received: from engestrom.ch (cpc87083-finc18-2-0-cust120.4-2.cable.virginm.net. [92.238.93.121])
        by smtp.gmail.com with ESMTPSA id i5sm18222212wjx.15.2016.03.13.08.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Mar 2016 08:38:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqd1r5mw4p.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288753>

Hi Junio,

Thanks for the warm welcome, but after your explanation on the purpose
of the second field, it looks like my patch was just a plain bad idea.

I'm not that new to git (I've been using it actively for 6+ years), but
as you guessed, I thought it was just redundant info as I had never see=
n
a tag with a different remote name (unlike new branches, for which you
always see the `remote/branch` name), and I thought I might as well
replace it with an other info. As you mentioned though, a tag can be
used everywhere its hash can, so there's no point showing that either.

I guess I'll just take that as a lesson :]
  =E2=80=9CMake sure you actually understand what the code is doing
  before trying to modify it=E2=80=9D

Cheers,
Eric


On Mon, Mar 07, 2016 at 08:28:06PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > But I am merely guessing from the your patch text what the reasonin=
g
> > behind the change was and you are the one who had the original
> > reason why you needed this change, so your "why" may be a lot more
> > useful use case than the one I made up and called "semi-sensible"
> > here.  The proposed log message needs to explain your "why".
> >
> > And if you explained "why", you may have heard other people agreein=
g
> > with you that this new piece of information is nice to have.  They
> > may even have helped you by suggesting to add this extra informatio=
n
> > somewhere in the output, instead of replacing existing information
> > in the output (which would lead to loss of convenience and
> > information).
>=20
> I just thought of another possible explanation why you may have
> thought that it is a good idea to clobber the right hand side of the
> fetch report.  Perhaps you thought that LHS and RHS say the same
> thing and that is redundant?
>=20
> Because "git fetch" is flexible and allows you to store what the
> remote side called X locally as Y, the fetch report in the most
> general form must say X on the remot side) was fetched and stored as
> Y in the local repository, i.e.
>=20
> 	[new tag] X -> Y
>=20
> but it is excusable that people new to Git who never saw such a
> renaming fetch to misunderstand that we are giving redundant
> information.
>=20
> If that was the motivation, a possible way to change the behaviour
> would be to show
>=20
> 	[new tag] X
>=20
> if and only if the remote side and the local side uses exactly the
> sae name for the ref.  The lack of " -> " can clearly tell the user
> that the output is telling us that what they call X is fetched and
> stored as X (i.e. under the same name) locally.  A fetched ref that
> does not update any local ref (i.e. the ones that are recorded only
> in the FETCH_HEAD file) is shown as
>=20
> 	tag X -> FETCH_HEAD
>=20
> so there is no ambiguity there, either.
>=20
>=20
>=20
