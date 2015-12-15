From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v1 4/4] git gui: allow for a long recentrepo list
Date: Tue, 15 Dec 2015 00:04:55 -0000
Organization: OPDS
Message-ID: <71B00739215A4176BA65000AF1CBBBD4@PhilipOakley>
References: <3453668A49C94C2AA39911FC594AE151@PhilipOakley><1450105743-2432-1-git-send-email-philipoakley@iee.org><1450105743-2432-5-git-send-email-philipoakley@iee.org> <CAPig+cSE41rHyq8hNcEL+qJaZrSwp0uc=Y6gPiRcj_T1EgQ4cg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Pat Thoyts" <patthoyts@users.sourceforge.net>,
	"Alexey Astakhov" <asstv7@gmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 01:05:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8d6y-0008M4-9n
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 01:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816AbbLOAE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 19:04:56 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:63307 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932197AbbLOAEz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 19:04:55 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DbDgC6WG9WPCSzBlxeGQEDDwEBAQGDClJuh02zToIngVcMFwqFYgQBAwEBgTA6EwEBAQEBAQEGAQEBAUABJBuELwUBAQEBAgEIAQEZFRYIAQEhCwIDBQIBAxUDAgIFIQICFAEEGAIGBwMUBggLCAIBAgMBDASIBgwJqyCGVYtWgQGFVYR9hDWDQi+BGgWWdgGBLoQGijOacCMBhEM+NAGDNYFKAQEB
X-IPAS-Result: A2DbDgC6WG9WPCSzBlxeGQEDDwEBAQGDClJuh02zToIngVcMFwqFYgQBAwEBgTA6EwEBAQEBAQEGAQEBAUABJBuELwUBAQEBAgEIAQEZFRYIAQEhCwIDBQIBAxUDAgIFIQICFAEEGAIGBwMUBggLCAIBAgMBDASIBgwJqyCGVYtWgQGFVYR9hDWDQi+BGgWWdgGBLoQGijOacCMBhEM+NAGDNYFKAQEB
X-IronPort-AV: E=Sophos;i="5.20,429,1444690800"; 
   d="scan'208";a="68743020"
Received: from host-92-6-179-36.as43234.net (HELO PhilipOakley) ([92.6.179.36])
  by out1.ip02ir2.opaltelecom.net with SMTP; 15 Dec 2015 00:27:22 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282454>

From: "Eric Sunshine" <sunshine@sunshineco.com>
> On Mon, Dec 14, 2015 at 10:09 AM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> The gui.recentrepo list may be longer than the maxrecent setting.
>> Allow extra space to show any extra entries.
>>
>> In an ideal world, the git gui would limit the number of entries
>> to the maxrecent setting, however the recentrepo config list may
>> have been extended outwith the gui, or the maxrecent setting changed
>
> s/outwith/without/

Ah, it's a Scottish english word, which better 'translates' as as outside, 
rather than being a commutation ;-)

I'll see if there are any other comments before a re-roll.

>
>> to a reduced value. Further, when testing the gui's recentrepo
>> logic it is useful to show these extra, but valid, entries.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>> diff --git a/git-gui/lib/choose_repository.tcl 
>> b/git-gui/lib/choose_repository.tcl
>> index ad7a888..a08ed4f 100644
>> --- a/git-gui/lib/choose_repository.tcl
>> +++ b/git-gui/lib/choose_repository.tcl
>> @@ -153,7 +153,7 @@ constructor pick {} {
>>                         -background [get_bg_color $w_body.recentlabel] \
>>                         -wrap none \
>>                         -width 50 \
>> -                       -height $maxrecent
>> +                       -height [expr {$maxrecent + 5}]
>>                 $w_recentlist tag conf link \
>>                         -foreground blue \
>>                         -underline 1
>> --
>> 2.5.2.windows.2
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
