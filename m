From: David Barr <davidbarr@google.com>
Subject: Re: Objects deleted before first commit
Date: Tue, 14 Jun 2011 22:57:54 +1000
Message-ID: <BANLkTikSPNVbGFRUVh5eSFsxabVWT7SVVA@mail.gmail.com>
References: <8269100C7056D24A91B672AF7E5E48492D959E@exchange.GottexBrokers.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Edmondo Porcu <Edmondo.Porcu@gottexbrokers.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 14:58:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWTBz-0007hq-BF
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 14:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab1FNM56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 08:57:58 -0400
Received: from smtp-out.google.com ([216.239.44.51]:56889 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab1FNM56 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 08:57:58 -0400
Received: from hpaq2.eem.corp.google.com (hpaq2.eem.corp.google.com [172.25.149.2])
	by smtp-out.google.com with ESMTP id p5ECvttJ026330
	for <git@vger.kernel.org>; Tue, 14 Jun 2011 05:57:56 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1308056276; bh=3TCdEAhCYYcncQDJIMexzaIogO4=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	b=xlCt59/vklySFFQTMYFXqRuFJXsrtOINebGCVXYAedx9cAVP3WcD64mVPehxNPv2R
	 Ht/pgoOiPQ097RVR+T3GQ==
Received: from yxh35 (yxh35.prod.google.com [10.190.2.227])
	by hpaq2.eem.corp.google.com with ESMTP id p5ECvHNv010293
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 14 Jun 2011 05:57:54 -0700
Received: by yxh35 with SMTP id 35so1133113yxh.2
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CXX4BTUtGaDxcC5ydgxngb12MJxFnYipPqvUbdj7fEY=;
        b=QY8bLIy955A45vg6i8xWiAhXRYXENGfyyXF0ImjLROfmZ4qoSMZX2bZasBCruwNDQO
         0ItKqrsPkVQJ+lgeptMA==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PbgpsWHomdWLYlxyOsAh/tQ7fmutVckCvj1MzW8xsZKX5frU/M42KrYLtTbwX8eUF/
         tvdMpFyfk25MOb6bNquA==
Received: by 10.101.8.8 with SMTP id l8mr6535180ani.69.1308056274241; Tue, 14
 Jun 2011 05:57:54 -0700 (PDT)
Received: by 10.101.29.2 with HTTP; Tue, 14 Jun 2011 05:57:54 -0700 (PDT)
In-Reply-To: <8269100C7056D24A91B672AF7E5E48492D959E@exchange.GottexBrokers.local>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175766>

On Tue, Jun 14, 2011 at 10:43 PM, Edmondo Porcu
<Edmondo.Porcu@gottexbrokers.com> wrote:
> I have created a git repository, and then I have deleted by error some files with rm -rf .
> Now the files have disappeared from the hard disk, I am desperately looking on how to restore them. The objects folder is full of dangling objects, but I do not know how to recover them.

If you did use 'git add' to stage your work before the unfortunate
invocation of rm, the blobs should be accessible.

Something like the following might work:
git show `cd .git/objects; ls ??/* | tr -d /`

This will pretty print all loose objects.
--
David Barr.
