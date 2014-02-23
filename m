From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: allow initial sparse checkouts
Date: Sun, 23 Feb 2014 15:43:47 +0700
Message-ID: <CACsJy8ApmVPAnhQmVAsFyXtV49S+9VULsEYZ7W3x7HMMoVtDzA@mail.gmail.com>
References: <1393122713-4308-1-git-send-email-robbat2@gentoo.org>
 <CACsJy8BKJ4HzXLcajC8cXviD4hboRPOYhWSen7H5Ta=_JuXNjw@mail.gmail.com> <robbat2-20140223T072340-334493350Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 23 09:44:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHUfv-0002pL-Gs
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 09:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbaBWIoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 03:44:19 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:53170 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaBWIoS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 03:44:18 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so5206447qaq.29
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 00:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=DFMCVNiLj7o5sB2t69WnCh0tbdOZU415/+AjzxPHOOM=;
        b=Oz8szsFV6uS6bFBqtEV/DYuRK7zr6dEiG8B9PeaBLClOYViSswBbGBZTLSar3ZbAiB
         Bqq9j56vhcVB4fG8/+mjQ0ecewreImyX2MGyYkXrYuVNIA3a28FNG7giRaZHOWM8maDH
         XgWUjxazI6uoyHVMXbCva8LRQj69/RQJuhi+SgIBgKnQGmxwnrFycKWvQqZRGuZ68O0i
         zm6/X7wT1vst1fFPPTgb8sSv6fUxhHXqhnuVET6DIjjYLT609+v6VYkezhV4Qeqi7lH+
         foBwQsLVFyFCF1wP0wqry3rGwk7NuQEpke3sOCMCfRQZvSiamfQ13Azdi8V29VTCdGmb
         CE6g==
X-Received: by 10.140.84.40 with SMTP id k37mr14431788qgd.98.1393145057616;
 Sun, 23 Feb 2014 00:44:17 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sun, 23 Feb 2014 00:43:47 -0800 (PST)
In-Reply-To: <robbat2-20140223T072340-334493350Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242537>

On Sun, Feb 23, 2014 at 2:32 PM, Robin H. Johnson <robbat2@gentoo.org> wrote:
>> > This patch implements easily accessible sparse checkouts during clone,
>> > in the --sparse-checkout option.
>> >
>> > $ git clone REPO --sparse-checkout PATH
>> Or take a file as input if there are lots of paths/rules.
> How much demand for taking a file of rules,

I don't know. I guess it depends on each repo's layout. If the layout
is simple, usually you would need one or two rules so it's ok to type
again and again. If it's more complicated and starts using '!' rules,
it's probably best to save in a file.

> and opinions of syntax to do
> that vs specify on the commandline?
>
> --sparse-checkout-from FILE

I think this one is better. But if you don't see a need for it, we can
always delay implementing it until an actual use case comes up.

> vs.
> --sparse-checkout '<PATH'
> or something other prefix character.
-- 
Duy
