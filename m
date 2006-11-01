X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 1 Nov 2006 23:09:41 +0000
Message-ID: <200611012309.42675.andyparkins@gmail.com>
References: <200610261641.11239.andyparkins@gmail.com> <200611012118.11558.andyparkins@gmail.com> <7vodrq251z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 23:12:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=L7npqmGFEPhNp5tfR+XfHx24kd2jJC91gXYVIRaxTogSCYYc50c9R6ADCOdOc5v9yveQByOgyQcj6zOcKmvG8Ka3B9RhT+9eV/bq8m5P3zeJYHMy18IIdkr4WNRyAlvWXfAU9gBzcZDhGLuKNMxq/cqZem4WpzYc9KMP52hpvrs=
User-Agent: KMail/1.9.5
In-Reply-To: <7vodrq251z.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30673>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfPFq-0002Ii-8X for gcvg-git@gmane.org; Thu, 02 Nov
 2006 00:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750836AbWKAXMN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 18:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWKAXMN
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 18:12:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:49400 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1750836AbWKAXML
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 18:12:11 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1856970ugm for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 15:12:10 -0800 (PST)
Received: by 10.66.244.11 with SMTP id r11mr8974151ugh; Wed, 01 Nov 2006
 15:12:10 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id o30sm1291027ugd.2006.11.01.15.12.09; Wed, 01 Nov
 2006 15:12:09 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006, November 01 22:08, Junio C Hamano wrote:

> > x --- y --- z
>
> I assume when you do the following operation your .git/HEAD
> points at 'y' which is already committed, and 'z' does not exist
> yet (it does not come into the scenario you describe below).

Sorry, yes, it's there merely to get in the way.

> You forgot to mention at the same time it makes .git/HEAD point
> at 'x'.  That's the part I am not so sure about.

Hmmm, no I had imagined that in path mode HEAD would not be updated because 
that would change the whole commit instead of just the particular file.

> Ah (lightbulb goes on).  So after the above reset, you would do
> a "git commit" with or without -a to create a fixed-up 'y' that
> does not have changes to 'frotz'?

That's the one.  It was described in another response as cherry-picking 
content instead of commits.

> Then it sort of makes sense.  --soft with paths specifier does
> not make much sense (paths specifier is a no-op in that case
> because --soft does not touch index nor working tree), but I

Agreed.  --soft + path can't have any effect because it only updates HEAD, 
which has no meaning in reset-path mode.

> Ok, that workflow certainly makes sense.

When this thread gets looked back upon, is it going to be strange that you 
say "yes, making crazy changes makes sense"?  :-)

> That's the "mechanical point of view only" description I was
> afraid of having.  While I think I now see why they can be

I must have a "mechanical point of view" brain.  I can't see any further than 
the gear wheels.



Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
