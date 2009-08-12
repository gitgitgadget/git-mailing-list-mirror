From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: git gc expanding packed data?
Date: Wed, 12 Aug 2009 15:45:16 +0100
Message-ID: <3ace41890908120745y305b2a59hd453b7e146e4a774@mail.gmail.com>
References: <3ace41890908041325v24ed9e2eh95ecc148305f7775@mail.gmail.com>
	 <alpine.LFD.2.00.0908042203380.16073@xanadu.home>
	 <3ace41890908110317k6e6ada07jc39ea446f9fa246e@mail.gmail.com>
	 <alpine.LFD.2.00.0908111718490.10633@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 16:45:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbF4z-0000Af-Tg
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 16:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbZHLOpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 10:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbZHLOpR
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 10:45:17 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:58332 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbZHLOpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 10:45:16 -0400
Received: by ewy10 with SMTP id 10so60898ewy.37
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3vRtAYmE8hyJMVhTmxYbOghO84T6dysvaInHKc03lhU=;
        b=J+J7+CoIX/oJDEX0eN/IOv0hxySVA8v2XTqy2TuS635PAH724D/oDm/kmmaBnDJupy
         a5U8DpNn8lKBBKgg0XSC8klqRzZve851nEMRgffa6ZLBA1Ee/hTWLGwD07e0RFWsiu+X
         T/AJLfLXuShsdMClP9vWyG2oOxmm2rMFacUqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SIXPNTbII3jxbPbUGBRI+Ed5+pHTK66KFTOQkJQlewuUXi8HPDw/OW9yma5HqwXuEh
         bjpCDtB7PxfqLwWmPshPVgDUw6w/KjPqmnsd6jWKfmN8yIqqz2QaKfoDoZ4qlq/rC6M7
         Vqv4aJpqkyrUMj71pDIuHi3g7Lbhtp0VfzLvE=
Received: by 10.216.89.141 with SMTP id c13mr28150wef.66.1250088316445; Wed, 
	12 Aug 2009 07:45:16 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908111718490.10633@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125704>

On Tue, Aug 11, 2009 at 10:33 PM, Nicolas Pitre<nico@cam.org> wrote:
<snipped>

> From git v1.6.3 the --aggressive switch makes for 'git repack' to be
> called with --window=250 --depth=250, meaning the equivalent of:
>
>        git repack -a -d -f --window=250 --depth=250
>
> Do you still get a huge pack with the above?
>
>> I guess --aggressive doesn't always save space...
>
> If so that is (and was) a bug.

I tried 'git repack -a -d -f --window=250 --depth=250' with 1.6.2.5
(fc11.x86_64) and it took half a day, swallowed up all the memory -
3GB virtual & 1.3GB resident - and finally the kernel oom killer
killed it at a last message of (601460/957910). Left no temp files.
Would git 1.6.3 use less memory? :-(

Hin-Tak
