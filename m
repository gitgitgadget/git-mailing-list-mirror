From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] git clean -X behaviour when .gitignore has sub-directory
 entries
Date: Sun, 3 Oct 2010 14:12:09 -0500
Message-ID: <20101003191209.GA22743@burratino>
References: <4CA0AB9A.4050002@nuecho.com>
 <20100927203652.GB11957@burratino>
 <4CA8D1B4.1020801@nuecho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Shawn Bohrer <shawn.bohrer@gmail.com>
To: Jean-Philippe =?utf-8?Q?Gari=C3=A9py?= 
	<jean-philippe.gariepy@nuecho.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 21:15:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2U1z-0002fB-9T
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab0JCTP0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:15:26 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56616 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab0JCTPZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 15:15:25 -0400
Received: by qwh6 with SMTP id 6so2620071qwh.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VudaU6jxqU5Ot/wDg3//1ruRWrchu7YIoGP+AFYq3tM=;
        b=Md52NCiUnHodq/z8SZ5odFInhgG0a9KeBzsTaTtxj0RJ6DzvImC3ojkzt3HgjxI0+Z
         16txOr0UYbRo26UPluSpdngtkumZ0d9427cDrs25qnMih35S7zODr9LeITaqD1HbvUF6
         H6Ln9q7Q8eLZ+qf+ETCppnHA5TJ3u2wfqCJzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TvaO+thLcUN7c4yABfYBSTMz2wB2mbjZI4/SjH4nxoTNAVkDZOuqkBARno6UXsOWaH
         ozj9plVeGy55UQrOxlHGgATnIU3LTltsDuu60+lyVatIz2rb+nK/g3FDqksYq2bcw9lo
         mA+qhiLkF7AcvLAJgwvezGBxze3ozFnz34YeE=
Received: by 10.229.189.74 with SMTP id dd10mr6183584qcb.73.1286133324489;
        Sun, 03 Oct 2010 12:15:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id e6sm4368112qcr.5.2010.10.03.12.15.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:15:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CA8D1B4.1020801@nuecho.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157892>

Jean-Philippe Gari=C3=A9py wrote:
>  On 09/27/2010 04:36 PM, Jonathan Nieder wrote:

>>...
>>  1) a/b/f is not actually considered excluded; only its containing
>>     directory is.
>>
>>  2) git clean does not even examine a/b to consider whether to remov=
e
>>     it: since a/ does not contain any tracked files, it stopped ther=
e.
>
> Ok, thanks for your analysis.  Do you consider it a bug?

Yes.
