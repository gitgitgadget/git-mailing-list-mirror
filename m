From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 28 Feb 2007 18:42:13 +0000
Message-ID: <200702281842.15147.andyparkins@gmail.com>
References: <Pine.LNX.4.63.0702281535070.22628@wbgn013.biozentrum.uni-wuerzburg.de> <200702281515.10016.andyparkins@gmail.com> <Pine.LNX.4.63.0702281630430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 19:45:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMTnZ-0002hi-Fs
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 19:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbXB1SpG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 13:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbXB1SpG
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 13:45:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:44156 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbXB1SpE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 13:45:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so199570uga
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 10:45:03 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Jgy9TvoB3Q/Kg2yw52p45oP4HrFU2qmqlvwrsyVwQ2kpKhJDZ3dJv/fCRQmFPYbuvqHUK8vzfOpQuox3QaJrWHhZ5Q8/YIgF8IASH8uZn7iWXJ2TCTRqtvaXrym1lMK5NaU82TffK+jmjE+/z4vGAJjbw6BsbM1pcjY6/AjYjeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=f7a9z25gGYfexDyyTvF7Icb7ups0M3e4XNf7BibNi9fMhZrI3tvAqZk8hV2AeoyVzLAJ4GQfAhMNQZspKmrnGu4e0VZgsUT0ed02ZkIbj4nm0USRi1h0879YFOxhDw/Ts7HIKLwiAAolOxIzMMUELdIFvphMuzsCDNdMl7sf9Oo=
Received: by 10.67.22.14 with SMTP id z14mr1178616ugi.1172688303012;
        Wed, 28 Feb 2007 10:45:03 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id a1sm951837ugf.2007.02.28.10.44.59;
        Wed, 28 Feb 2007 10:45:00 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.63.0702281630430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40987>

On Wednesday 2007, February 28, Johannes Schindelin wrote:

> for added files (and the obvious thing for deleted ones), but with
> your patch, both added and deleted get
>
> 	Bin 123456 bytes
>
> which is not so optimal.

See my corrected patch.  However, while you're interested: how would one 
tell the difference between 0 bytes and (no file).  I'm thinking of 
these possibilities:

 new -> 123456
 0 -> 123456
 123456 -> deleted
 123456 -> 0

For example - does mmfile_t.ptr set to NULL mean anything?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
