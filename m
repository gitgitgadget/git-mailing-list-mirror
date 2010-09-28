From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Pull request for msysGit patches
Date: Tue, 28 Sep 2010 21:23:19 +0000
Message-ID: <AANLkTinpSwuhT1_wtqNBeXLCud-F0bLBUgbohdtPp+8R@mail.gmail.com>
References: <87ocbitd33.fsf@fox.patthoyts.tk>
	<7vocbhsn03.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	bert Dvornik <dvornik+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 23:23:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0he7-0004EA-FH
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 23:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab0I1VXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 17:23:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43171 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab0I1VXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 17:23:20 -0400
Received: by iwn5 with SMTP id 5so120786iwn.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=lzk6ly61FYqnIHqK/q1fj2z/i2H5mUxOgVjhXBSYkhc=;
        b=f6ZI6mJaHKA/2d0QyzDtWlL1wAN5lgPXogiJKNDD43EdqF6jV/pjMVvB6g+V1uFV98
         /qNvxSqGj/MowBF6GyQac87sI7J5fAKW81Zvgzy739zEnAWAcCEsN80g7kJPuV/Ch9sP
         l3lmqTYxBT1+Ud3GNqj3wvMjIFeM8OEifHebE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PBf1nGgEu3RD2t397VG34bmNtnkwsobxFqBIsUULfNLEmzNE0oGCtZrGbJLhdWf+L2
         ruJauCnSDk3Fk97wq293lcjzmsGyHQYJO6II9gY3pnzawVXSQeNZjoYgSs1DLV+qaPbe
         HJHsUIjebkrC4KILsyqB9fr27S1+/judZ83hc=
Received: by 10.231.36.77 with SMTP id s13mr531788ibd.190.1285708999627; Tue,
 28 Sep 2010 14:23:19 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Tue, 28 Sep 2010 14:23:19 -0700 (PDT)
In-Reply-To: <7vocbhsn03.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157477>

On Tue, Sep 28, 2010 at 19:10, Junio C Hamano <gitster@pobox.com> wrote:

> git-send-email.perl
>
> Similar comment as is_absolute_path(), although in Perl environment I
> suspect we can just use an existing package without adding our own.

It seems to me that the code added by Erik Faye-Lund in
33b2e81f84875bf515b4c0de830eeddfd04227dc and this new code in
"send-email: handle Windows paths for display just like we do for
processing" by bert could both be replaced by:

    use File::Spec::Functions qw(file_name_is_absolute);
    file_name_is_absolute($some_path);

And by doing so we'd also be compatible with e.g. VMS. Can the people
with the odd non-Unix systems maybe try this out and see if it works?
:)
