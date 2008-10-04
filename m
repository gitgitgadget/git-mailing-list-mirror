From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use "git_config_string" to simplify "remote.c" code in "handle_config"
Date: Sun, 5 Oct 2008 00:46:29 +0200
Message-ID: <81b0412b0810041546w5eed8859vd8266bb66425ebd3@mail.gmail.com>
References: <20081003033937.GA11594@eratosthenes.cryptobackpack.org>
	 <48E5AD8A.4070301@op5.se>
	 <20081003200613.GO20571@eratosthenes.cryptobackpack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
To: "David Bryson" <david@statichacks.org>
X-From: git-owner@vger.kernel.org Sun Oct 05 00:49:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmFvt-0005Al-9U
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 00:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbYJDWqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 18:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbYJDWqb
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 18:46:31 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:54002 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbYJDWqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 18:46:30 -0400
Received: by yw-out-2324.google.com with SMTP id 9so345228ywe.1
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 15:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KTWBNZWVliphSuVWOwuSIwiBgiz9t1EZP/F+BI8P89E=;
        b=fRfb2jjtyMQXx1J+5CibRGbHE6okwiHz1vxDo/Rgq8MH0Agr27I6IOzXDMkA6fg/LS
         3jtDi414d6YRlpyZDHQHVorU8jQk56HyUDckVR+WiwG17HOa+KU38/EADPzrAu90wruW
         beSOckbFHHL9rEvlGJ4r4lOc373BQandtDLvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qTw59rtYNZKAsUN0vfGN6kII9oBgaFrMX0URPB1qLJyP/KLotExW1npOm+RIHuE7Uc
         B4ckNNzgAM42A6Bn2vwvlWW73Jh5Rln6qLbGH8kzoMbix2Em58ghnmS08Rn6+le18sXx
         WwF6SHSyVgJAqLuOpZpQZZ3/11Hm28ifpia9M=
Received: by 10.100.139.2 with SMTP id m2mr372474and.114.1223160389669;
        Sat, 04 Oct 2008 15:46:29 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Sat, 4 Oct 2008 15:46:29 -0700 (PDT)
In-Reply-To: <20081003200613.GO20571@eratosthenes.cryptobackpack.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97482>

2008/10/3 David Bryson <david@statichacks.org>:
> On Fri, Oct 03, 2008 at 07:28:42AM +0200 or thereabouts, Andreas Ericsson wrote:
>> David Bryson wrote:
> Oh I agree entirely, it is quite vague, however like I mentioned I tried
> to keep to the conventios in the file.  This strategy(v) is used in several
> other places in remote.c, if this is Bad Code, then I have no problem
> changing it.
>
> Thoughts from anybody else ?
>

You can redeclare of the variable in the contexts where
it is used and not even rename it: it is close to its users then.
