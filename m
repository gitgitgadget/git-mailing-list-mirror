From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/3 v3] Use an external program to implement fetching with 
	curl
Date: Wed, 5 Aug 2009 11:15:40 -0700
Message-ID: <fabb9a1e0908051115u145b2b0bi2973bcf41d5ef68f@mail.gmail.com>
References: <alpine.LNX.2.00.0907310112400.2147@iabervon.org> 
	<alpine.DEB.1.00.0908051203550.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051135080.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:16:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYl21-0000Mc-Ch
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbZHESQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbZHESQB
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:16:01 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:40367 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbZHESQA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:16:00 -0400
Received: by ewy10 with SMTP id 10so195418ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 11:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KoeEiZZZnHLw8+j+51+EZx5KCSSb2QVi9QdFJyqn8WM=;
        b=ZTrhR/oiRPShop2egAA3OW88HivlSmP8qw9kI0AYOips/ONWdj+IPBKtfb3v+UNQzk
         9EsyBtV4ZTbwImeJBo9V+C2PliIDmfgFg34sHI/alMAw6/g6Fieqe2YzDBvCUB9fvk+I
         YmhdRelQK22CzOi+ZZgTTum3xPwxrIerEuaTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rCYKQ43bpR1QVsRF9g8n4C3n4/V1PEU19yCSQPQDbHxI3j7vHKmd1jUjEfag8R+q/+
         jbosH+ayOBPk+1BbBHccGDRAldZnH0M3oAZZLaPsuCRSWvwVSULdMviZ9e1hXWkoaKWU
         znZJJjZ4HNYC198XkB203/Vyo9Ez5x+OhwjyQ=
Received: by 10.216.8.213 with SMTP id 63mr1872161wer.161.1249496160106; Wed, 
	05 Aug 2009 11:16:00 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0908051135080.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124939>

Heya,

On Wed, Aug 5, 2009 at 08:45, Daniel Barkalow<barkalow@iabervon.org> wrote:
> Someday, I want to
> have a diff output format that makes these things clear somehow. I think
> it would be not-too-hard to get the diff code to determine that an
> addition matches or almost matches a deletion (or some unchanged code),
> and provide library access to this information, but representing it to
> humans (and getting patch to still work) is hard.

I started on this a while ago (as part of some post-GSoC git-stats
work), but I had a hard time finding a good rule to determine whether
an added hunk is similar enough to a deleted hunk elsewhere. Perhaps a
variant of Levenshtein can be used to determine how different two
hunks are; I tried diffing the two hunks and then looking at the
ration between the size of the diff and the size of the original hunk,
but as said that didn't really work out.

-- 
Cheers,

Sverre Rabbelier
