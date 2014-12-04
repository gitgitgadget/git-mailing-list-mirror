From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/23] expire_reflog(): remove unused parameter
Date: Thu, 4 Dec 2014 15:20:54 -0800
Message-ID: <20141204232054.GC16345@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:21:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwfhm-00012g-6h
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933229AbaLDXU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:20:58 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34157 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbaLDXU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 18:20:58 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so15545177igj.16
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 15:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Osh+JsIToz/UKAhcxS1TYoo0vpKsj9CAvP0XQLjk7lw=;
        b=njFYCMy7uppY+CR9KwT5E85erCzKjHm0SZHQTD7qli0PEzs7kdG5JaImNqB99EdKpr
         O1WVyJn5iUHCPRDujDNgM/ER9xynktQSU2UrMhi+VNS9J7m4VKYhw9Xtxg2ZCD1If+nj
         Dmzb8SbWH97bHiHAw58cZw32FIqssAfrBu7OJzxZzNwWzEf6WnnXq5JQfsTI0SeoO47L
         buxxVZrQjGY39x5Ux2ywV5kXZ+7w+N5C9m3nzzx/NND+pyRNMLVBBHFqG30473a9r38D
         SGhpmMaERhjWEVaz2V9qgtB3/NDwv53dFK0KcgxeE/3mK0CS5ZwIE00dswkS6fLrK2XE
         YmAQ==
X-Received: by 10.107.161.19 with SMTP id k19mr12016774ioe.60.1417735257254;
        Thu, 04 Dec 2014 15:20:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5da0:cb9e:66b:e537])
        by mx.google.com with ESMTPSA id ga3sm16052676igd.10.2014.12.04.15.20.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 15:20:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-5-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260834>

Michael Haggerty wrote:

> It was called "unused", so at least it was self-consistent.

The missing context is that this was a callback function that had to
match the each_ref_fn signature (where that parameter is 'flags')
until v1.5.4~14 (reflog-expire: avoid creating new files in a
directory inside readdir(3) loop, 2008-01-25).  v1.5.4~14 forgot to
clean up.

With or without a note in the commit message explaining that,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
