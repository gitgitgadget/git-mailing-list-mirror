From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Sun, 29 Aug 2010 21:38:12 -0500
Message-ID: <20100830023812.GA4010@burratino>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 04:40:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpuIU-0007HP-8W
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 04:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210Ab0H3CkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 22:40:04 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34145 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab0H3CkC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 22:40:02 -0400
Received: by gxk23 with SMTP id 23so1806636gxk.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 19:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NPU+YWPWZ0iE7JKhsLe2q6WK3/ZDJEvJ6VdQBlktoHs=;
        b=mGZNNnI1d5XG18dk+p5Uwp+OdfC0Efo3EMmtAS/5PbvXYk5T3ooNy3/Tq9eVwChoh+
         qpXM3Z7tpxFp/GeBaePHJPqS8s7JLQycntGlQ1sR+j+L4jgI/vhm0XIjPjeEnt7CzbxU
         YWhsKDb3Vx5nZEgHOV7DqW8T87Q9kmVUY6uJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pb54e8knOMc0S3+oBohXwthAHHruYzWL122aYm/oWpVG1sirY7HJYyLEReMnGcoXYT
         sm9t5CdN1nxBBPpB7q9JVXQ6/qXau8HfXS53K0u3Gb5a8bPaej7RWU9wJx8RDNum+8rq
         7/T7RnLjX1wvoZN0iFSd6UtWEtNAeJuT2Tr2s=
Received: by 10.100.153.15 with SMTP id a15mr3848276ane.179.1283136001935;
        Sun, 29 Aug 2010 19:40:01 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e18sm8887676ana.15.2010.08.29.19.40.00
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 19:40:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154753>

Thiago Farina wrote:

> Promote cmd_version to a builtin, by moving it to its own file
> in builtin/version.c

Could you explain further?  If the goal is "one command per source
file", then we already violate that in a number of places:

 - "git blame" and "git pickaxe" are both cmd_blame() in
   builtin/blame.c.

 - "git whatchanged", "git show", "git reflog", and "git log" are
   separate builtins in builtin/log.c.

 - etc

What does this make easier?
