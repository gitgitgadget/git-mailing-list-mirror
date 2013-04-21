From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 13:53:28 +0530
Message-ID: <CALkWK0n+Q6EWy6StGvgwvLf5mZqZfhaCvG70zD=2a0rK3qRLCQ@mail.gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-5-git-send-email-artagnon@gmail.com> <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
 <CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
 <7v8v4cwd6g.fsf@alter.siamese.dyndns.org> <CALkWK0kiT7vggXgqGs2iiMooiw7TyJEgr2=Yy06S7H1NKiWJ3g@mail.gmail.com>
 <7vzjwsuxzp.fsf@alter.siamese.dyndns.org> <CALkWK0kEngwYQieR=Xmvzu+XqBe+ZFxiWj0C8M-euFavDDaD2Q@mail.gmail.com>
 <CAPc5daV39HsoRR2pj34Tz1kQKFVRrp+NZpMM2BremocqvToA+A@mail.gmail.com> <CALkWK0mmvwnRzq5eYTzvZRmEwn7nyDLe5cJsV1iQvNnh1Y7xEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:24:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpZL-0001Ap-BG
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab3DUIYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:24:14 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:54419 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab3DUIYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:24:09 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so6135194iej.30
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=euKD4jed427vLfGW/uSJm+uuddBViUTeEi3ZaPPFJ8Y=;
        b=bbjgnS/sDFuvowa8kp47nYkh4g/nYK9sUN564/mo3inP62/YnBLV7EuQSN8VGVTUOW
         R5yMSrbIKZ5I9O10yQsX4coUF1NrR0nQ21LUmmD1tvOXmFCyi+hYROZN9gvoaSPJZJhm
         wc/swRNsjZ9JbOrcZCJFhfoowTVUt5JM6CX4zqRtW8R3NA7G5QzCxcDmzZGgPdZx9sb8
         4JY4i79/oqtKZ6yQO0zXdhDlCZIBatmdZjxbJkOMj2o0jPTZPqdE3QiYoAwPTRw4F+NV
         vAlKEBkyPAjeRHicS2hawtEO+FTJiZmuzGNzxqWCEHHoOChPP1OlV8aX9s32G6lEHtBF
         KAhA==
X-Received: by 10.42.50.202 with SMTP id b10mr11017364icg.7.1366532648516;
 Sun, 21 Apr 2013 01:24:08 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 21 Apr 2013 01:23:28 -0700 (PDT)
In-Reply-To: <CALkWK0mmvwnRzq5eYTzvZRmEwn7nyDLe5cJsV1iQvNnh1Y7xEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221921>

Ramkumar Ramachandra wrote:
> '<rev>'::
>         Include commits that are reachable from (i.e. ancestors of)
>         <rev>.
>
> This doesn't make sense because <rev> might as well refer to a blob*.
> So this should say s/<rev>/<rev> that names a commit object/.

In other words, my fix is to change the meaning of "revision range" to
not literally mean "range of revisions", but rather "range of
(revisions that are commits)".  I think it is more sensible than
Jonathan's fix which breaks too many existing things; most
significantly, the names rev-parse/rev-list.
