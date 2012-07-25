From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/5] difftool: Simplify print_tool_help()
Date: Tue, 24 Jul 2012 19:18:00 -0700
Message-ID: <CAJDDKr6JcbKkvg-9M6Sf4i0+YrMFJeKhmVoxQ_g1QBCRnoGRxw@mail.gmail.com>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com>
	<CAFouetjhGChULHa-Ax9oR--TccyEBnqn=UATbMpJxcdm3AOE1w@mail.gmail.com>
	<CAJDDKr47F9ZAPPCnFBdPYhQsx8qGGggHHrFWeZw2zpf-mukq5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Tim Henigan <tim.henigan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 04:18:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StrBW-00046Z-Tr
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 04:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab2GYCSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 22:18:04 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36687 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab2GYCSB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 22:18:01 -0400
Received: by vbbff1 with SMTP id ff1so185261vbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 19:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EPBfVKLqoT5VSqP1p3Vbc9AHrP2QSFctL9ZoRL71IF0=;
        b=iLEzt2wq+HU+Wb9SG2FibxRRBkm3BUBgJ5MWX0XueeaVWY5phiD8hOBnwqE+RFKmrI
         d0wxwi9U4l516ALBd6gQQ9i6d+H6TQvhhYxTxeduDfczvOURRqcwAhTZsewZrcObGZBN
         8lj1FX5QrSo2bl0XYxzA5eknYwCopTV2+SN/YPwEmzIcoxyZ+/lLqJtEhVKjyFfL5ghf
         jnz0Dm+F//Ri+ZRDTbdKYjf2BzuR7/5W7lBjvulH8+L1tGpTyZDRJZ4MrprEECFcVQLa
         CNu8elgw9iVBC7/GlLrftq9KeisdQWsnwy9VIy2MfndkPKU9V3nMJJhfsXN7gh2MLFwF
         FcBw==
Received: by 10.220.148.210 with SMTP id q18mr16900303vcv.6.1343182680960;
 Tue, 24 Jul 2012 19:18:00 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Tue, 24 Jul 2012 19:18:00 -0700 (PDT)
In-Reply-To: <CAJDDKr47F9ZAPPCnFBdPYhQsx8qGGggHHrFWeZw2zpf-mukq5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202091>

On Tue, Jul 24, 2012 at 6:52 PM, David Aguilar <davvid@gmail.com> wrote:
> On Tue, Jul 24, 2012 at 5:43 AM, Tim Henigan <tim.henigan@gmail.com> wrote:
>> On Sun, Jul 22, 2012 at 11:42 PM, David Aguilar <davvid@gmail.com> wrote:
>>> Eliminate a global variable and File::Find usage by building upon
>>> basename() and glob() instead.
>>
>> glob was used in an early revision of the patch that led to bf73fc2
>> (difftool: print list of valid tools with '--tool-help') as well [1].
>> However, if the path to git or the path under 'mergetools' includes
>> spaces, glob fails.  To work around the problem, File::Find was used
>> instead [2].
>>
>> Does this implementation handle that case?  I'm sorry, but I haven't
>> had time to apply and test myself.
>>
>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/193233/focus=193925
>> [2]: http://thread.gmane.org/gmane.comp.version-control.git/194158
>
> Good catch.  Eliminating the globals should be the goal, then.
> I'll have to re-roll.

These landed in next.

Junio, would you prefer follow-up patches or a rebased series?
-- 
David
