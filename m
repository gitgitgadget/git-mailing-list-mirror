From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sun, 25 Jan 2009 23:03:28 +0100
Message-ID: <200901252303.29204.jnareb@gmail.com>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <alpine.DEB.1.00.0901251622310.14855@racer> <7vwscjceec.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 23:05:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRD6D-0005gD-E6
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 23:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbZAYWDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 17:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbZAYWDg
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 17:03:36 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:40649 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbZAYWDf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 17:03:35 -0500
Received: by ewy14 with SMTP id 14so69948ewy.13
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 14:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VxrjllmefCzDTqdOvb3nub5MKggUivFCAepNESfaJNk=;
        b=dL8q34W2P8cRPQQO4Ifzk82nA/jonIxgwOfWIm0Ag+EzqZo+BarRlC4b+j3M79vmbx
         ScZ7CU63uuUZ5ksb0oKrnbun9UvfICEzw4XTD1rYGPEsxdFam9Gk8KdcUSYveaBDpAfe
         TB6udzE2pgLPBr9+U0825TrbI/yiw/WJ/ej/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HonK1ePnXRJUzPQHCkEcT2R7WFsrnoNkBPrIyr7MNGp3FDG6TnztrzYRVu1ZrdSk7q
         tP56lLQrYg1g9gJ2BEXxCSQBuqW5VTOwrN8FUHMt1ZbPSYxJ15DVmP1HCZ1i9PbYjn0U
         bhc3nB5ipPcocB+PaU0HLFsYvTd15DDN38eLw=
Received: by 10.210.65.17 with SMTP id n17mr4334931eba.112.1232921013581;
        Sun, 25 Jan 2009 14:03:33 -0800 (PST)
Received: from ?192.168.1.15? (abvk161.neoplus.adsl.tpnet.pl [83.8.208.161])
        by mx.google.com with ESMTPS id b36sm26649893ika.19.2009.01.25.14.03.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jan 2009 14:03:32 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwscjceec.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107108>

On Sun, 25 Jan 2009, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > So maybe I answered my question myself:
> >
> > 	merge parents $sha1 [$sha1...] original $sha1 $msg
> 
> When you are reparenting, how would original commit get in the picture?
> You wouldn't want the resulting merge to claim it merged X (which would be
> what's in original's commit log) when in fact it now merged Y because the
> user reparented it, would you?

Well, the subject part of merge (with merged branches names) shouldn't,
I guess, change. The summary (shortlog) part might, or perhaps even
should following rewrite (if it was present here).

But there is one issue I am wondering about: could we pick up _merge_
_resolution_? So if you have evil merge, and the change is for example
splitting commits without visible final changes, or just changing some
commit message before merge, it would get recreated without problems?

-- 
Jakub Narebski
Poland
