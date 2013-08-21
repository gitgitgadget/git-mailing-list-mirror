From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Wed, 21 Aug 2013 02:01:53 +0200
Message-ID: <CABPQNSbBMNtww0GKBQVtpE3v=4p86qYBNBmSzDz70TAa7fq7WA@mail.gmail.com>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com>
 <33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley> <166132E40AA54EE387BA9B4558823C55@PhilipOakley>
 <CABPQNSZidMv4MEW+SqVm94pX4szw9QW8LFWsvBTOXYH7ezzycw@mail.gmail.com>
 <87eh9op5gq.fsf@igel.home> <CABPQNSZSXgvLw_i25em38B70EgtZrv9iQh8OaCJzYRCk2vjZXQ@mail.gmail.com>
 <87y57wnf03.fsf@igel.home>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>,
	"Koch, Rick (Subcontractor)" <Rick.Koch@tbe.com>,
	Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Aug 21 02:02:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBvsk-00014m-Is
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 02:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab3HUACe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 20:02:34 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:36087 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab3HUACe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 20:02:34 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so2145466oag.26
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=kXWtGarJywp/cterTJBr8BYqkftBoipaT2bemdz8RyI=;
        b=z2MsZ+NNi5xVHbOx5XGPMdBlqw7eAYp5x4/hkQOgNAOtWCzlloGzxcXViaY/o2Su07
         g2pQctkiNcYC+JftgYgnv3ci2PsMPvYQXBveUjYhUMAiWfxeo0eptG/5/OedHjZnQ7gC
         JcAkePhEUf0enSxhrLNd2TmLUSxvgLbjQ4E2Ouq1FCl4Lli3fQl8wadDSDYxft97jul8
         XqEf1fMRtkpah+4BSjtsJXR+KgVtqaYra/oeOpp1dzFC0/1mXsfVmpHEnbRmi2dnZv4M
         eXLbCg1BHts5XZ9j3lW+Q+Q1AKE/HFYo5Spt+nsTGdGoQb+jkyrttoV657z0XHVBeial
         QnsQ==
X-Received: by 10.60.140.168 with SMTP id rh8mr4772112oeb.76.1377043353645;
 Tue, 20 Aug 2013 17:02:33 -0700 (PDT)
Received: by 10.76.162.68 with HTTP; Tue, 20 Aug 2013 17:01:53 -0700 (PDT)
In-Reply-To: <87y57wnf03.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232671>

On Wed, Aug 21, 2013 at 1:01 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> I don't see how it's undefined. It's using the memory that 'pos'
>> *points to* that is undefined, no? The difference between 'pos' and
>> 'str' should still be the same, it's not like realloc somehow
>> magically updates 'pos'...
>
> It does.  Think of segmented architectures, where freeing a pointer
> invalidates its segment, so that even loading the value of the pointer
> traps.  Probably no such architecture is in use any more, though.
>

Wow, you're right. And since doing it the right way is pretty much the same
complexity (and possibly even a bit easier to follow), that's probably the
best thing to go with, then. Thanks for keeping me straight!
