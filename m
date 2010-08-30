From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Mon, 30 Aug 2010 09:52:20 -0500
Message-ID: <20100830145220.GI2315@burratino>
References: <cover.1281985411.git.j6t@kdbg.org>
 <4C6C01A9.4080306@workspacewhiz.com>
 <AANLkTinwQqwjmeNfiUE6LiZtbBhEEFyisZXUgF9_b+2Q@mail.gmail.com>
 <201008182032.40375.j6t@kdbg.org>
 <AANLkTimtmudtWccRS==LrO_JrPmAJ7HzA6CU0ALbDZcV@mail.gmail.com>
 <4C7BC344.9020500@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:54:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq5kT-0002PT-Fe
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab0H3OyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 10:54:06 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57329 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab0H3OyF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 10:54:05 -0400
Received: by vws3 with SMTP id 3so5067264vws.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/J0RrFap0ORY4uVKQJ1+uhHAfEeogmZ8EDc2edcwLBM=;
        b=hqJL5PrqKCoGqOwCJth+DZyvqMyMzzwJiOKewCm0NeYhPX0LiWHCGuJi35UXjhtfl6
         aeIoloTDCtp8S83lgqkwBv7uBRXZsdPxfd0FLG5SKq4sXIC7ndb4EuUcyTvCh7Q0bbon
         nKdd3hKnm0WzkSWAwUGWLL/g7LTPUuDO88B1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k5S+4RBzRLVR47RxWNF128iM0kSo4mNskX1qP3I3LBQEcCz2Vx4MzpN1aLT74wlSAp
         65AZqkdzbvfIan18bmFH6Ptl+3nLao9KrT3d/wncWkmMqhtkgQrMoFs73ClNHf0pc08g
         8GXTNyqCEr8cfcW7zEhcTRJf/Hb7tj+Ir5HO0=
Received: by 10.220.49.204 with SMTP id w12mr2696651vcf.243.1283180044115;
        Mon, 30 Aug 2010 07:54:04 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id m30sm4253063vbr.9.2010.08.30.07.54.02
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 07:54:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C7BC344.9020500@workspacewhiz.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154819>

Joshua Jensen wrote:

> I don't like the idea of
> a double memory allocation/free combo per each call to this
> function, but it would work.

Maybe the caller can provide a (strbuf) buffer?
