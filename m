From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 15:00:51 +0530
Message-ID: <CALkWK0m=g3evr83ci5ZnTFHSEnCb_fRSer0j+sw1rRaaKDnY1A@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <7vvc7baahc.fsf@alter.siamese.dyndns.org> <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
 <CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
 <7vppxj6thv.fsf@alter.siamese.dyndns.org> <CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 11:31:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVIWi-0001i3-OY
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 11:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245Ab3DYJbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 05:31:33 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:50441 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460Ab3DYJbc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 05:31:32 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so2538875iaf.18
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=r/gri5wt3CZkddw8rdxGv69NEDM6T42FJ1dJFinI8lQ=;
        b=O2gESLTVs+ghUJwUS3TfyiiKCCFFbwxFNExjdfNCsL3B6Tevrdg0YnHd1R25iVG2Gv
         BQN6EKIhCwl5x3+aUJ3oGb3sAlzLv2OYvoM/8bkOc4/sP1GwpCDeMQqA42JFDf3hGDZY
         GwqTFwBx5Mhbdrp10tZNGtlSlB5/NVPTffpYkhsySeX/TDtKaFn/IndkZwgyO8yIGZ+6
         jlKUorBbcdNmAMxE66WwPvzV/n7MjWnFBjFAvisqDx4+HkTTMuV2lTgvQAlf5w/nbuT7
         5+TyVg4UuZm/iZeb+DOnNtD9Vc++snRwoyfmIqozVqouI+uxjuUcUYLGXKxBECX9c78Y
         /wDg==
X-Received: by 10.50.57.200 with SMTP id k8mr30903177igq.44.1366882292104;
 Thu, 25 Apr 2013 02:31:32 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 25 Apr 2013 02:30:51 -0700 (PDT)
In-Reply-To: <CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222360>

Ramkumar Ramachandra wrote:
> $ git diff rebase.autostash ^$(git merge-base rebase.autostash master)

So, Thomas pointed out on IRC that there is one edge-case: a
criss-cross merge.  So, we can define A~B as B ^$(git-merge-base
--closest-to=B A B).  If both A and B are equidistant from the
criss-cross merge [will that ever happen in practice?], we have no
choice but to error out.
