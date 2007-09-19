From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: State of Perforce importing.
Date: Wed, 19 Sep 2007 19:56:50 +0100
Message-ID: <3f4fd2640709191156q18d8eb1cg609f0ad209cf8144@mail.gmail.com>
References: <20070917193027.GA24282@old.davidb.org>
	 <20070918233749.GA19533@old.davidb.org>
	 <200709190819.12188.simon@lst.de>
	 <20070919171243.GA23902@old.davidb.org>
	 <3f4fd2640709191123j64b53878vc96d785c13c3bca2@mail.gmail.com>
	 <20070919182545.GA2266@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Reece Dunn" <msclrhd@googlemail.com>,
	"Simon Hausmann" <simon@lst.de>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:17:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY4jM-0003An-K2
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 20:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721AbXISS4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 14:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756106AbXISS4x
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 14:56:53 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:46164 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755721AbXISS4w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 14:56:52 -0400
Received: by an-out-0708.google.com with SMTP id d31so44444and
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Bam+R5Gp7auAZnO1FX8Hy+WNFADXQlaI/X8nMP0n9Qs=;
        b=i30hc5Xc6EK8Ao7k4fo8ClzkMr8qQ2BbCBm5W38Nz9H6dtq37LTdrcL1reYTlxC0c6Muwz3O4NDT9SGzbFLLqGnZQrI4rapCrGpHRiwJKxCUXTI10jJiyzcP4Ru2JTNbaKWbuxhD/vFSsynXK72osbi/DN1nNRwSFYZt3Q8CK7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZA+LNTftnhrJ0jRp4GTtGGENgExSFFHHR75PWhwnclePISk/E2+C1HLGuJKodnA8fxecOWFscR6DrMO5ZU11eHnMX8LFngJBOQBi3nM8PT9NU4uAVkMwW1M26aUwjasIzUuBge/u6xMonpfKY2jHIiSSJvPhHEmsr6gjYtX5kvk=
Received: by 10.142.179.12 with SMTP id b12mr435524wff.1190228210580;
        Wed, 19 Sep 2007 11:56:50 -0700 (PDT)
Received: by 10.141.87.20 with HTTP; Wed, 19 Sep 2007 11:56:50 -0700 (PDT)
In-Reply-To: <20070919182545.GA2266@old.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58723>

On 19/09/2007, David Brown <git@davidb.org> wrote:
> On Wed, Sep 19, 2007 at 07:23:41PM +0100, Reece Dunn wrote:
>
> >> I think it would be sufficient to check the first or second character for
> >> an 'x'.  I'll make a change and give it a try later today.
> >
> >These are the old file types. If you read the output of `p4 help
> >filetypes`, the new way of specifying this is with file type
> >modifiers. Therefore, you also have things like text+x.
>
> So my patch I just sent may not be sufficient.  Thing is, we set the file
> type as 'text+x' and it comes back as xtext, so I'm not sure if P4 ever
> gives out text+x or if that is just available as a new way of specifying
> them.

I'm not sure. The Perforce help says that xtext and its variants are
there for backward compatibility. If you are running an older server
with a new client, or the other way around, they may be doing a map
from text+x to xtext so that the old version can work properly. This
is just speculation, though.

I don't know enough to say what Perforce is doing. I find it strange
that it is reporting xtext, when you specified text+x.

Have you tried a combination that is not supported? Is xunicode
supported, in which case you could try unicode+x (if you have a file
that you can experiment with)?

- Reece
