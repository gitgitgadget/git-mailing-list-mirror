From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 18:49:24 -0500
Message-ID: <20100326234923.GA18759@progeny.tock>
References: <20100326215600.GA10910@spearce.org>
 <20100326222659.GA18369@progeny.tock>
 <20100326222950.GB10910@spearce.org>
 <4BAD3C6E.4090604@gmail.com>
 <20100326230537.GC10910@spearce.org>
 <4BAD41C4.7050508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, git <git@vger.kernel.org>
To: "Mike.lifeguard" <mike.lifeguard@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 00:49:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvJHL-0004Gi-AF
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 00:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab0CZXtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 19:49:22 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:59048 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab0CZXtV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 19:49:21 -0400
Received: by ywh2 with SMTP id 2so3842323ywh.33
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 16:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7LnNg/QDNvLI3YzZwJemkUe+fEsNbhwFxGupm70vQKk=;
        b=xvXPEmrm6sE2WVbg/YdQ4zmyS2aywWsOlNxVorDEEYUvQuZrXfpD7PfiqhTI8WvG2N
         GqA5K3HAR4YPmMYjE65hLM5rxjdyx+rWEFVOadmMPK452kmo5p4f/5hLV09Fxlefj3+/
         kO0TVVjnOfY2RCThKvaH1sAhUE0+ot/T97744=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TVq4wUKGDYPaqIplMv+DKhh8s1csrpZ5q2haa10l0bqG/K2awPuIe0hfwFAPiVD3E2
         Jdp29FCa6wmefCITElp6b2MOFo2sZwWx8B1NXJXDR0CedXNZWkLsUTTxgBQt2xkWQJ+p
         sVeNpM6xLUF9zgUgiD03LgwCwKhdMqnmOCV1M=
Received: by 10.151.86.8 with SMTP id o8mr2146696ybl.201.1269647361052;
        Fri, 26 Mar 2010 16:49:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1234290iwn.2.2010.03.26.16.49.19
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 16:49:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BAD41C4.7050508@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143301>

Mike.lifeguard wrote:
> On 10-03-26 08:05 PM, Shawn O. Pearce wrote:

>>   $ git filter-branch --index-filter '' --all
>
> This and a few other variations I tried does rewrite things, but the
> problem persists:

Yes, I think git write-tree does not rewrite subtrees.  How about

git fast-export --all |
(
	cd /empty/repository &&
	git init &&
	git fast-import
)

?
