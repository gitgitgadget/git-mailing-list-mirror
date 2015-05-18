From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1020: cleanup subdirectory tests a little
Date: Mon, 18 May 2015 11:30:44 -0700
Message-ID: <xmqqsiatbuwb.fsf@gitster.dls.corp.google.com>
References: <1431972817-18178-1-git-send-email-sbeller@google.com>
	<xmqqwq05buz1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes.Schindelin@gmx.de, Jens.Lehmann@web.de,
	git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 18 20:30:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuPoR-0004cW-DF
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 20:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbbERSar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 14:30:47 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35247 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932127AbbERSaq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 14:30:46 -0400
Received: by iesa3 with SMTP id a3so90548753ies.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NALOnUEHLJs238xiBZ2TNEKa9DiGQoDF6KYIoTHFeoE=;
        b=EDMW2WLgrpJLCqT+AKvRE/gzwXflPaXt1pvD1RixrdqC6l4s5HfL288rUnXqGQsUBm
         SofAHPpwH6WPRcyKzIkiQHhs2ZWhLTZYjcTdY+ktdw4OBo6p3DdsUh6uF6uWptMtgJxo
         pnEnxb3iEZ4eoY6RegdH90GnNkKIyMMDqQCnLbrarhcuBqxrX53YSw55If9DSCxRI1+E
         Yia5JtZM2xVl7l9uDsqK+4CYPwdZdk/XL4plZ+c2NBXUH7+dhexI08vf+L1O2670Up9J
         tgn3bdPRfwY8P5WZxzl0Q6B5PaxCadahhsisGBx0p6wDM6/BaxLb+U9a4VdKzmm2UJzc
         ISqg==
X-Received: by 10.107.37.211 with SMTP id l202mr15793963iol.76.1431973845990;
        Mon, 18 May 2015 11:30:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2120:a5f3:f7b6:7da9])
        by mx.google.com with ESMTPSA id l30sm8211264iod.12.2015.05.18.11.30.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 11:30:45 -0700 (PDT)
In-Reply-To: <xmqqwq05buz1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 18 May 2015 11:29:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269295>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> When looking through existing tests to point out good style I came across
>> t1020, which has a test commented out and the comment wasn't helping me
>> either of what the test should accomplish in the future. The code of the
>> test is the same as the test before except setting GIT_DIR=. explicitly,
>> so it did not ring a bell for me as well.
>
> I think this one should be clear, especially if you did notice the
> one that sets GIT_DIR=. explicitly.  It is saying that "git show -s
> HEAD" inside the bare repository should be intelligent enough to
> realize that it is inside bare repository (hence HEAD cannot be a
> file in the working tree); the user's asking for "HEAD" therefore
> must mean "the tip commit", and never "(by default the tip commit)
> filtered to the pathspec HEAD".

I forgot to conclude that sentence: "... and it should be able to do
so without the help of an explicit GIT_DIR=."

> If it does not still work, shouldn't it be marked as
> test_expect_failure instead of being commented out?
