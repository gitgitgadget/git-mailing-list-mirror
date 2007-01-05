From: "Chris Lee" <chris133@gmail.com>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 5 Jan 2007 15:03:26 -0800
Message-ID: <204011cb0701051503m3a431e07qc12662eecc08884f@mail.gmail.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	 <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
	 <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
	 <7v1wmalez6.fsf@assigned-by-dhcp.cox.net>
	 <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
	 <7vbqldfg56.fsf@assigned-by-dhcp.cox.net>
	 <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
	 <20070105193958.GE8753@spearce.org>
	 <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jan 06 00:03:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2y63-0000xM-WC
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 00:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbXAEXD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 18:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbXAEXD2
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 18:03:28 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:7378 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbXAEXD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 18:03:27 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7225100wxd
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 15:03:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VSYM/THzs6G744u6iWoUtCMtfNxEUmkwi6oEIpymM73WNlVD3rr4pJ5FYsnDkUKX1f+aThzj3Xx7Cmgc+QtH9UIRBUpHWVm8pv8OgmdhGIUHT0qhTIzRQ0v+kpTJSiDKy4A/QD1tMStAvH9eCS5KZkdegeV64JsS0ALgu7k44b8=
Received: by 10.90.32.14 with SMTP id f14mr959784agf.1168038206704;
        Fri, 05 Jan 2007 15:03:26 -0800 (PST)
Received: by 10.90.81.19 with HTTP; Fri, 5 Jan 2007 15:03:26 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36041>

On 1/5/07, Junio C Hamano <junkio@cox.net> wrote:
> Subject: [PATCH] builtin-prune: memory diet.
>
> Somehow we forgot to turn save_commit_buffer off while walking
> the reachable objects.  Releasing the memory for commit object
> data that we do not use matters for large projects (for example,
> about 90MB is saved while traversing linux-2.6 history).

Is git-verify-pack supposed to mmap the entire packfile? Because the
version I have maps 2.3GB into RAM and keeps it there until it's done.
