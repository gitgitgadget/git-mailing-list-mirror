From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] format-patch: autonumber by default
Date: Thu, 2 Oct 2008 15:10:40 +0200
Message-ID: <cb7bb73a0810020610q657dec7clf85b4ef3575b751f@mail.gmail.com>
References: <1222946860-15518-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <alpine.DEB.1.00.0810021433130.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 02 15:11:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlNyC-00065h-96
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 15:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbYJBNKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 09:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753542AbYJBNKm
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 09:10:42 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:58126 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbYJBNKl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 09:10:41 -0400
Received: by gxk9 with SMTP id 9so1296149gxk.13
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=p5Kg5ne3BhY3LhyNjdQg6gBxd2ApEFexARb4J9m0ntY=;
        b=ZzCeDKP0EZHNLccoOD54IfHvJmIK2Upt9S/ClJOpCpAIPldqUJAPoxPbSWqRtfV0V1
         EL9npPB76GfEMWsr1f5+FDqgPyknnMSqiSz2DBK4vCA1tuSnNeXO/q6gnxx5yRu2dECc
         yykd0unBT6vmLpQurhF0/nvQobfWmG1hUjuDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jKv6yRjfJ7HF8I7eYHhOd2WJWB/cvQNQL4eBN5SKRgABlLg1pyLQ5EVE7PAe95D+DJ
         zgjARYZiJyyAm3V6f/Pe02qnFL/j1LrPHxkU/pV4lVdvyb/jCIuRv2ytvK9HQ2Gzn9cT
         Z4YHbUGm8rLj9dzaMOeaGuP5MFVIOpw4bS1ac=
Received: by 10.151.145.11 with SMTP id x11mr2580764ybn.21.1222953040082;
        Thu, 02 Oct 2008 06:10:40 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Thu, 2 Oct 2008 06:10:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0810021433130.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97324>

On Thu, Oct 2, 2008 at 2:33 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:
>
>> Set auto-number true by default, allowing the format.number key to be
>> set to 'noauto' to override this.
>> ---
>>  builtin-log.c |    6 +++++-
>>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> Interesting.  No sign-off, no defense why this is actually desirable,
> after we lived for so long without this behavior... Care to elaborate?

Doh, sorry about the Sign-off, I'll resend with.

Now, about the reason for this patch: I would say that the most common
use-case of format-patch being used to prepare multiple patches is
when one plans on sending a patchset. When format.numbering is set to
auto, single-patches will still be extracted without numbers, but
patchset will be properly numbered.

Of course, there may be cases where one doesn't want numbering (for
which there is the -N flag already), and of course we want to give the
user the choice to disable autonumbering at the config level, for
which there is the new noauto option for format.numbering.

If this explanation is good enough for you, I'll plop it in the resend
message too :)

-- 
Giuseppe "Oblomov" Bilotta
