From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/4] completion: be nicer with zsh
Date: Mon, 30 Jan 2012 12:25:47 -0600
Message-ID: <20120130182547.GA22549@burratino>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
 <1327944197-6379-5-git-send-email-felipec@infradead.org>
 <20120130175324.GH10618@burratino>
 <CAMP44s0ACC+AnwHGtBLe8C1S_sxWj6SbMbawDThvLQAA0pKMYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipec@infradead.org>, git@vger.kernel.org,
	Lee Marlow <lee.marlow@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:26:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrvvY-0003eO-64
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab2A3SZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 13:25:59 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40086 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab2A3SZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:25:59 -0500
Received: by ghrr11 with SMTP id r11so1921121ghr.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 10:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QF+JwaMTnfDRdlDLKWBLZ9f1kNoG+6R5wIUxtvIrNOE=;
        b=CX8JOfky1Kepxjlfzf2OoKuhZ+PeUohhTjKxQ1Pjo/MHB1F+x7ynCkaJj89ssDNn2W
         C7xON9lRdIfPX4YRTjRJpD7PXtPNlC2sTpqLkuYVt53m6fiDBwOCU85+DhD1mgHoKfDF
         +yTt86O3PfgCKrLJq4/JQhROGvXhuSShjgeI4=
Received: by 10.101.201.19 with SMTP id d19mr8448673anq.39.1327947958458;
        Mon, 30 Jan 2012 10:25:58 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id o11sm27168022anl.11.2012.01.30.10.25.57
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 10:25:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s0ACC+AnwHGtBLe8C1S_sxWj6SbMbawDThvLQAA0pKMYQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189392>

Felipe Contreras wrote:

> The commands might fail, that's why '2> /dev/null' was used before,
> and ':' is used right now.

Wait, what?

: is a no-op command.  It does not redirect stderr automatically or
do any other magical thing.

[...]
> And IMO harder to read. But you are correct that most of the code uses
> [[]], which I think is a shame. But I guess people want to keep using
> that.

[[ has simpler syntax wrt quoting and other details.  But now that I
check, the code uses [ a lot, too (which, like "test", is a plain
built-in command), so I suppose consistency is the only reason to
prefer one over another.  "git log --grep='if \['" tells me the use of
'[' instead of 'test' here is deliberate.
