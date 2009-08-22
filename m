From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] Re: [PATCH 01/14] Fix non-constant array creation
Date: Sat, 22 Aug 2009 12:35:17 +0200
Message-ID: <40aa078e0908220335t6071fd4ay160827619fa9ab6c@mail.gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
	 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
	 <40aa078e0908210641m660b003do6f637535293672ae@mail.gmail.com>
	 <4A8EA53B.9080809@gmail.com>
	 <9d6091530908210926p61aa5ea6ya6a7b71f940fdf5a@mail.gmail.com>
	 <4A8EFE29.6010706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Janos Laube <janos.dev@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: "Johan 't Hart" <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 12:35:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MenwX-0005uZ-60
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 12:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509AbZHVKfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 06:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755469AbZHVKfR
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 06:35:17 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:59882 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343AbZHVKfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 06:35:16 -0400
Received: by qyk3 with SMTP id 3so59682qyk.4
        for <git@vger.kernel.org>; Sat, 22 Aug 2009 03:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nGrcxqvBVS1C7bO2oGVt6IDqgiBY7cydylQEjC44Hno=;
        b=xzfnFiekQWFJMAXSs/QL9oQWsArZWEUzCxs2ZA3L0SXfyyOI2dNaloyb1is/gCZMtf
         wXmhNd5uBokIWHM9Ow/dog2ETyiXRIz2OSumF0dS6yvoYJQ2B5UJlorsmWd9+DMAl4D9
         +uxplSMSrHFa96nVPjy4xhA8O5GCvsjESqO2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WHfRkpPYWd8xRH+EqWpVfNTuQKKMZRrfjzawOuuope8kM44e8fx2jUiu8NdtS/DdS+
         1OGQbwpQqcDPNrLA8/578R2H94tHTenOU6WYeO6xi2XEhVXRzuStdNnPnqqkJ4b9Pilx
         CO/e1RM+b4bMiOKE09RekBIabd7O+Tr/03WVA=
Received: by 10.224.117.14 with SMTP id o14mr1476801qaq.334.1250937317655; 
	Sat, 22 Aug 2009 03:35:17 -0700 (PDT)
In-Reply-To: <4A8EFE29.6010706@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126804>

On Fri, Aug 21, 2009 at 10:06 PM, Johan 't Hart<johanthart@gmail.com> wrote:
> alloca() throws an exception when out of stack memory. But what would the
> dynamically alloced array do when it runs out of memory? (Supposing that
> those arrays are also created on the stack, which I don't know...) Is that
> realy more complicated?

You get a run-time error. Or rather, you get a run-time error if
you're out of address space. If you go out of memory, swapping
mechanisms are used. And in turn, if the swapping mechanisms fail,
you'll get a run-time error AFAIK.


-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
