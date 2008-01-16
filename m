From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 15:20:43 +0100
Message-ID: <200801161520.44668.jnareb@gmail.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <m37ii9nagt.fsf@roke.D-201> <alpine.DEB.1.00.0801161600030.5260@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:21:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF98q-0002vZ-9n
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 15:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbYAPOUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 09:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbYAPOUw
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 09:20:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:10898 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbYAPOUv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 09:20:51 -0500
Received: by fg-out-1718.google.com with SMTP id e21so296187fga.17
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 06:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=eAutk+twjgTBsDrd2ib/HESeKznG74IkhqV36UNdPgs=;
        b=kOXX2IfUt2eSIEIGrlFJLUghVelml0eDFFnntHW9/0laS7p9YLMEv9ycNi5GDyU36NAHVSyVdTJ3DHtyn/EU3ErbqZviUL9A2JGjHSNKg8EgTAbl5YstG0+BVCWJLHzb8LT4U9cIvPpykoKIIFb0TA04nI80Xi/TR44PQ6LJL3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=owgBZIqELZrWV2Hekn2I0ayFq4tUfdrrWWg0VyIAjVuZWpM53zmfBmZZKYxNHEEC2ooIqUMJeONi/KzZjqDwO4r6C7ZLtmLnpwhYdsoOoEVXM/fZl81iO6mt7w+7VxSJLHwePLMyMrUuMv1oLm+qNVKWR4MfEZSUiRu0SLKAqUk=
Received: by 10.86.58.3 with SMTP id g3mr758842fga.38.1200493250157;
        Wed, 16 Jan 2008 06:20:50 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.213.34])
        by mx.google.com with ESMTPS id e20sm1155781fga.1.2008.01.16.06.20.46
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Jan 2008 06:20:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0801161600030.5260@bender.nucleusys.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70678>

Petko Manolov wrote:
> On Wed, 16 Jan 2008, Jakub Narebski wrote:
> 
> > You can always tag a blob (like junio-gpg-pub tag in git.git repository),
> > but it wouldn't be in a working directory. But it would get distributed
> > on clone.
> 
> Hm, how does it work?

You use git-hash-object to put file (-t blob) into the object database.
It would return sha1 of added object. Use git-tag to create tag to blob
(use returned sha1 for head). You can get file (to stdout) with 
"git cat-file blob tagname^{blob}".

The file would be in object database, but not in working directory
by default.

> > BTW. if those large binary files doesn't differ much between version, 
> > they should get well compressed even if you would store them normally, 
> > all revisions.
> 
> Unfortunately this is not the case.  These binary blobs are already 
> compressed and/or encrypted and adding even a few bytes ends up storing 
> new version in full size.

Can't you store them uncompressed?

-- 
Jakub Narebski
Poland
