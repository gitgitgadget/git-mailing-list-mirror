From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Big performance regression with --no-color option in git-log
Date: Sat, 29 Sep 2007 13:29:30 +0200
Message-ID: <e5bfff550709290429n291968f2md8068a945ff7a79e@mail.gmail.com>
References: <e5bfff550709290302h6016c6e8mf9d5dfddce07d985@mail.gmail.com>
	 <20070929110130.GC4216@artemis.corp>
	 <20070929110914.GA32142@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 13:29:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbaVy-0000u6-OZ
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 13:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbXI2L3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 07:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbXI2L3e
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 07:29:34 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:4120 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbXI2L3d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 07:29:33 -0400
Received: by nz-out-0506.google.com with SMTP id s18so2205231nze
        for <git@vger.kernel.org>; Sat, 29 Sep 2007 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zRvc/udbFTtbjJIPdaN/7d7oQ1s3k1R7m0BJ19uxsBk=;
        b=SZjtgUugo6K32+EhuG21TFjlQ5rVXThaBAfcfeSoS1dA3V4ssApj/ayNehUWHRmIugD0GJMSfwjGBBI9GYCmKZERjFBc/oHb11JF9018ikMZH395oZuG61Zw95+RfFVSEWupueK4+NkOVIm5piMPfnDtKkyj/3x2pTtG48cLRDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LjFdWnvoFC1i8BBg1gyrgLKV5JckUdZdMTyOydkBRQvKjfvyEW9mKCq8meKS02RDcUnyeklmpU2/iMRVqC0y00PVn4VSWBgAToKMIXkmHds+Y6mbXtIImeQtQvxB7qBlIo3qMk+t/g/KvZwIZCZhEa9VVpiyzvd55I5qVPUCe8w=
Received: by 10.114.120.1 with SMTP id s1mr1870975wac.1191065370554;
        Sat, 29 Sep 2007 04:29:30 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Sat, 29 Sep 2007 04:29:30 -0700 (PDT)
In-Reply-To: <20070929110914.GA32142@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59461>

On 9/29/07, Pierre Habouzit <madcoder@debian.org> wrote:
> On Sat, Sep 29, 2007 at 11:01:30AM +0000, Pierre Habouzit wrote:
> > On Sat, Sep 29, 2007 at 10:02:23AM +0000, Marco Costalba wrote:
> > > On today git tree
>
>   Okay for me it's not only from today, and the issue seems to be with
> the fact that we pass options or that we don't... git log --color also
> takes an awful lot of time here, whereas it's my default. Looks like
> diff_opt_parse is called too many times.
>

There was a patch some time ago to fix a similar issue with '-z'
option (66e41f7b9912), perhaps the fix could be the same also for
--no-color, --color, or other new options that force to actually
compute diffs when is not needed.

Marco
