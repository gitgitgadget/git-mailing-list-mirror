From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 0/4] Perl rewrite of Ruby git-related
Date: Tue, 2 Jul 2013 05:01:29 -0400
Message-ID: <CAPig+cQdcMnDKbgae6fOmQ822go4RyvrKrzOwiEEoftFHHeZKg@mail.gmail.com>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
	<7vobamgqqh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 11:01:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtwSs-0004Of-9q
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 11:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401Ab3GBJBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 05:01:30 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:44398 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225Ab3GBJB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 05:01:29 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so11347125ief.40
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=UkGA7ynTeH5cHuuCBow3T/GLYWhUdmHXaLml7lNvjrk=;
        b=dvAQh6CaZ46QKSHh8eNSiQ1qCua1AefgYl4oQBnBGJ5bo6Axqz1B2rOi4+0Tcjjkw5
         CN9mkIXXgCx2xlCZtYQ+bzvQaYnYcAMnb0XdWMcEzhFOZcx8uQpSVKMpbnuI8BN1e5qa
         7dYb0ur9f3XWcctSrhlx3IclbSz4uxdugItfsT46SvTxk6bMXvfYV1OEfTzkuss97FPO
         bFR77kPI9OQxTdfo81WDpjpxXiBijDEbf4nlM2FYAnFVLlDDCJV7UKhIpY0QPfyuMz50
         72K0l6V99ODrSqSiNk7OrBL6TiLzt6n/ISt/zFL9bJq3lF2JcKeHOmZxUdycJ0SfjSBY
         dRRA==
X-Received: by 10.50.32.70 with SMTP id g6mr19773432igi.2.1372755689467; Tue,
 02 Jul 2013 02:01:29 -0700 (PDT)
Received: by 10.64.86.164 with HTTP; Tue, 2 Jul 2013 02:01:29 -0700 (PDT)
In-Reply-To: <7vobamgqqh.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: KLVPmxOUtpT0pmKrka6I1xgW044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229379>

On Mon, Jul 1, 2013 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> No attempt is made to answer Junio's v9 review[5], as I lack sufficient
>> insight with '-C' options to be able to respond properly.
>
> I just wanted to see if we want to allow the end user of this script
> to specify what -C level they want the underlying blame to use, or
> just a hardcoded one should suffice (and if so an explanation why).

It might indeed make sense to allow the user control over the -C
level, just as the user likely should have control over other
assumptions made by the script (to wit: $since = '5-years-ago';
$min_percent = 10). More fodder for future patches.

Now that I've read up more carefully on the -C option, I too wonder
why git-blame and git-show are invoked with different -C levels. At
the very least, I think they should be unified in this initial patch
to either one or two -C's. Since the script already is quite slow, I'm
leaning toward just one -C.
