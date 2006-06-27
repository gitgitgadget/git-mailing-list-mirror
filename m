From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Notes on diffcore API
Date: Tue, 27 Jun 2006 10:41:34 +0200
Message-ID: <81b0412b0606270141x7e38af5i8a97b27e37da17bf@mail.gmail.com>
References: <20060626233838.GA3121@steel.home>
	 <7v4py7h2b9.fsf@assigned-by-dhcp.cox.net>
	 <7virmn9hx8.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Timo Hirvonen" <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 10:41:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv98s-0004DI-8K
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 10:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWF0Ilg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 04:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWF0Ilg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 04:41:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:35875 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932577AbWF0Ile (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 04:41:34 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2469038ugf
        for <git@vger.kernel.org>; Tue, 27 Jun 2006 01:41:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k7RJSkQy8F3a5yw5EKU6mSxoPHRQ32cuBEiSJ8W78GNtMQ1Z+lrsKBwceitp+34dA9d6sHLs+6DAGv/NvHjL7ytLarfLsUWlsHpECJaFpW1pG9MdX2X1Nv3ZolOwGX01gYZwvj3kjQTuggK9ldSiFuMEnBx+/V0HOxU9x6uGezo=
Received: by 10.78.156.6 with SMTP id d6mr2408528hue;
        Tue, 27 Jun 2006 01:41:34 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Tue, 27 Jun 2006 01:41:34 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7virmn9hx8.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22714>

On 6/27/06, Junio C Hamano <junkio@cox.net> wrote:
> -- >8 --
> Notes on diffcore API
> =====================

Thanks!

> Diffcore Transformation
> -----------------------
>
> The input file pairs recorded in the previous phase are
> collected in diff_queued_diff (a global variable -- which means
> that you cannot have two diffs running in parallel with the
> current setup).  This is an expandable array of pointers to
> `struct diff_filepair` structure.
>

merge-recursive shouldn't have any problems with that, as the
renames are just read in the current implementation.
Still, it is somehow uncomfortable to see the amount of APIs
with the above restriction. Never know when it'll bite.
