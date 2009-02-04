From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Add new option to open an editor.
Date: Wed, 4 Feb 2009 17:42:59 +0200
Message-ID: <94a0d4530902040742o4f2f0b63g44d605e5b28d9b15@mail.gmail.com>
References: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>
	 <20090204145317.GA5712@sigill.intra.peff.net>
	 <94a0d4530902040703u53a9082fsfa7203b6203bd118@mail.gmail.com>
	 <alpine.DEB.1.00.0902041619370.22763@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 16:44:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUjvT-0005eO-N8
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 16:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbZBDPnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 10:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753148AbZBDPnD
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 10:43:03 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:39767 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbZBDPnB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 10:43:01 -0500
Received: by ewy14 with SMTP id 14so3449977ewy.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 07:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=H/9QHRJZ7HPZLIZogVh6x1oJUOKDTDq9uZThi9K/k3k=;
        b=Gr06CCdeEFZVIhXWYl5KRJ2SNV1uoUyvjshx3RG0jBKgsjzssfxJKIA81FhRn/L5+8
         9lic4ubDy3UlVoyMnZHJLAmo6pz3wsPqnu27YvLnj37gUHcBNsmM2LobjZFtmVTYn8B/
         wmJIaBQlTtcR829R+TgW0bIGPqfC8iC4waJZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C+8aJyJ5tGyQzcQnWW2dX11t+JXDmzRp+5m9sM1NoeVqiwlrOV/EDxgbPAw2nU7mtU
         DfgeVMiMOfORsYTJbtYZsBAZyxl5VwmuW0lVLVEsKto1JxGP3alxVYXDs0cJO+ZGdjhw
         fHFx5bbjnFdzNEk80Gmlf/30ESDxYbr8U+3IU=
Received: by 10.86.84.5 with SMTP id h5mr78578fgb.64.1233762179697; Wed, 04 
	Feb 2009 07:42:59 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902041619370.22763@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108384>

On Wed, Feb 4, 2009 at 5:20 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 4 Feb 2009, Felipe Contreras wrote:
>
>> On Wed, Feb 4, 2009 at 4:53 PM, Jeff King <peff@peff.net> wrote:
>> > On Wed, Feb 04, 2009 at 12:40:26AM +0200, Felipe Contreras wrote:
>> >
>> >> +             } else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
>> >> +                     char *config_filename;
>> >> +                     if (config_exclusive_filename)
>> >> +                             config_filename = xstrdup(config_exclusive_filename);
>> >> +                     else
>> >> +                             config_filename = git_pathdup("config");
>> >> +                     launch_editor(config_filename, NULL, NULL);
>> >> +                     free(config_filename);
>> >> +                     return 0;
>> >>               } else
>> >
>> > With this patch, won't I get different behavior from:
>> >
>> >  git config -e --global
>> >
>> > versus
>> >
>> >  git config --global -e
>>
>> Just like you get different behavior from:
>>
>> git config -l --global
>>
>> and
>>
>> git config --global -l
>
> ... which will be fixed once you parseopt'ified builtin-config, right?

I'm going to cleanup the big string, I still haven't looked at
parseopt, if it's not too complicated I'll do it.

-- 
Felipe Contreras
