From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 7/7] Factor ref updating out of fetch_with_import
Date: Thu, 29 Oct 2009 10:39:31 -0700
Message-ID: <fabb9a1e0910291039u3c9d7eb6qe36e25ea76cdddc9@mail.gmail.com>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com> 
	<1256798426-21816-8-git-send-email-srabbelier@gmail.com> <20091029142232.GS10505@spearce.org> 
	<fabb9a1e0910290853p49070443v6d6bf2bf75faf80@mail.gmail.com> 
	<20091029155607.GA10505@spearce.org> <fabb9a1e0910290932u45c9c416m4d0ba0a8b2f5b01d@mail.gmail.com> 
	<alpine.LNX.2.00.0910291311570.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 18:39:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Yyb-0001ne-SO
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 18:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482AbZJ2Rjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 13:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756212AbZJ2Rjs
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 13:39:48 -0400
Received: from mail-ew0-f209.google.com ([209.85.219.209]:33722 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756204AbZJ2Rjr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 13:39:47 -0400
Received: by ewy5 with SMTP id 5so240042ewy.37
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 10:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=HG0rPcYmxux4aYe7hiLWqibMv4mXKw50aJiuyDTA9JM=;
        b=ALLMDn93Rfr0N7/7WAXRvJWtCDqWoyb/TqgzG0eL2x7LwjKg2l0cHCYA9NLQDtbWgZ
         fMMrmKh3hec40gt78K8ZrDdCxDg+tuFjColHYNnAnv1bGNRc2YQNkuL/wE0Rzbpst5gm
         ev/oBHkQMlw/URKmzaWAHcCa6rJNQLgIgCAPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Whzsjk6BVI2aM8a6AucaPVrrNGwceLtXwTGbzovvrdyckw/qDncqWD3cbqT5SiGlKm
         FOrmkSCcLTeMRmC8uRSSdeESKuAQ5cLnn/FMbk29DL9VqVu8qZ/tE9ol476/v0CfAlyy
         N2BOkopjRTH4Hdj+IEe5NiXGzOso5qK4LWXaA=
Received: by 10.216.87.67 with SMTP id x45mr152745wee.18.1256837991120; Thu, 
	29 Oct 2009 10:39:51 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0910291311570.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131618>

Heya,

On Thu, Oct 29, 2009 at 10:22, Daniel Barkalow <barkalow@iabervon.org> wrote:
> (a) if HEAD is determined to be a symref, and we care about HEAD, we care
> about whatever HEAD is a symref to; wanted_peer_refs() shouldn't be
> filtering such things out.

It seems that wanted_peer_refs filters out HEAD no matter what though?

> (b) we don't want to make a whole bunch of copies of the ref list to avoid
> updating the mutable ref list that we will look for updated values in; the
> merge of my series with Nico's should replace my copy_ref_list with his
> wanted_peer_refs, not include the copy afterwards. Correcting this should
> lead to the value that matters in the list that will be used having been
> updated directly by transport_fetch_refs().

This I can and will fix. Patch-bomb incoming.

-- 
Cheers,

Sverre Rabbelier
