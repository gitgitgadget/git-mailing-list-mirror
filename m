From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2 2/2] i18n: mark OPTION_NUMBER (-NUM) for translation
Date: Wed, 6 Feb 2013 08:15:33 +0800
Message-ID: <CANYiYbF1cS=K9M0cwE5V0pUJMPEYGiJOjJwg5KQScCf8pjyTqw@mail.gmail.com>
References: <20130205121552.GA16601@lanh>
	<883efc2358a0deb48bee48134d45ddd528a732d3.1360080194.git.worldhello.net@gmail.com>
	<8d6d4d869ea58e0a26b3bb6377fc102728948997.1360080194.git.worldhello.net@gmail.com>
	<7vd2weu1sq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 01:15:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2sgA-00042A-Kd
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 01:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248Ab3BFAPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 19:15:36 -0500
Received: from mail-wi0-f179.google.com ([209.85.212.179]:45330 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab3BFAPe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 19:15:34 -0500
Received: by mail-wi0-f179.google.com with SMTP id ez12so977074wid.12
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 16:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=lEJTWvXYhDFGymZvfl74LUxAoWV4JvRym4QsLWxUuWc=;
        b=Gb+zODokW4x2/0nL3OEfQNgy8sBr8HCcXD55kBqRNf3+1FmzVd95hgo0QWZuqhwzaY
         2wfpzu3TTt1SGxij2SLFGCqGD7o/F6ndOj9Yc1twmh64ANkS0v/qMQpSIisItjBH8mwD
         1u+0m4YkHrOGa/Rl/axd6wMRCFHNSZTkEXukKWbSajOZUkjzSOux8Sv8q8yE7oz48GE5
         ZGNbEWRzXHaJ+BWFTaO/LxqEivSVxSM02O6a+PO/PpPE4bEhWsG70F3PehP2FxPSJMVF
         ECE92Fl19q4YtW9jtmPeYZtYvtewKbjiY2T1lHhEd/bYkAo+W198dOgvYAY8iTx3gWco
         besg==
X-Received: by 10.194.216.5 with SMTP id om5mr11806757wjc.27.1360109733444;
 Tue, 05 Feb 2013 16:15:33 -0800 (PST)
Received: by 10.194.110.199 with HTTP; Tue, 5 Feb 2013 16:15:33 -0800 (PST)
In-Reply-To: <7vd2weu1sq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215553>

2013/2/6 Junio C Hamano <gitster@pobox.com>:
> I somehow suspect that this is going in a direction that makes this
> piece of code much less maintainable.
>
> Look at the entire function and see how many places you do fprintf
> on strings that are marked with _().  short_name and long_name are
> not likely to be translated, but everything else is, especially
> multiple places that show _(opts->help) neither of these patches
> touch.
>
> I wonder if it makes more sense to add a helper function that
> returns the number of column positions (not bytes) with a signature
> similar to fprintf() and use that throughout the function instead.

I agree, a helper named 'utf8_fprintf' in utf8.c is better.
I will send a patch latter.


-- 
Jiang Xin
