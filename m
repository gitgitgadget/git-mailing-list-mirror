From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 10:30:42 -0400
Message-ID: <432ECB92.5000505@gmail.com>
References: <20050919134838.GC2903@pasky.or.cz>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Sep 19 16:33:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHMfU-0008Gb-9K
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 16:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVISOas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 10:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVISOas
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 10:30:48 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:23479 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932434AbVISOar (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 10:30:47 -0400
Received: by xproxy.gmail.com with SMTP id i27so9983wxd
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 07:30:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hldoegXMHEdF05QzhtYuovjHeE+sniicNaxfYRSYU+/bXvZ7ccpbSdFyfEZm/p2+LfcqHrLGVP3/jMZK1ge1xi2fzlZobzstBKG8vfbZo8e+CSsNBtbZfyaAPrORTnW4TH9lEr14Dq+n8gHOOkWBHAEY5UawEZs3f5tb7ZWOf5Y=
Received: by 10.70.8.10 with SMTP id 10mr887260wxh;
        Mon, 19 Sep 2005 07:30:45 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id i14sm297657wxd.2005.09.19.07.30.44;
        Mon, 19 Sep 2005 07:30:45 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050919134838.GC2903@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8865>

Petr Baudis wrote:
>   Hello,
> 
>   after today's another confrontation with angry mob of real-world
> Cogito users, I decided to revive the old discussion about what part of
> the GECOS field should be used to prefill GIT_*_NAME. Linus stated in
> <Pine.LNX.4.58.0504171636590.7211@ppc970.osdl.org> that he does not want
> to cut based on ',', because it might throw away the first name of gecos
> fields in the "Torvalds, Linus" name.
> 
>   Well, I have to say that from the GECOS fields I saw, none use that
> format, but a lot of them used the realname,phone,something,phone,...
> format. The other point is, that users usually do not expect their phone
> number to end up in their name information in GIT commits, which results
> in a very unpleasant surprise (doubly so due to the immutable GIT
> nature). Yes, they should check after the first commit if they are happy
> with everything, and yes, GECOS is world-readable and therefore they
> shouldn't put information they don't want to be public to it. Still they
> do and I think GIT shouldn't make them unpleasant surprises.
> 
>   So my proposal (patch will follow soon) is to cut everything after the
> first , or ; from the GECOS field. These are the usual delimiters used
> in the GECOS field, and hopefully this will prevent polluting the
> realname fields of commit headers with crap and surprising the users.
> In the (I think rather rare) situation of the "Baudis, Petr"-like GECOS
> fields, this will just result in only the surname being in the realname
> field, which seems to be much less harmful and comparably less evil to
> me. 
> 
>   Opinions?
> 

Petr,

Your view of GECOS field contents (formatting) does not match my 
experience. Many organizations, both large and small, have standards and 
requirements for the contents and formatting of information in the GECOS 
field. Saying that the user's name is first and a particular punctuation 
character SHALL be the standard cut point and everyone not happy with 
the results should explicitly set the Git environment variables is the 
wrong approach.

A better approach is to not use the GECOS field contents at all and 
force everyone the set the Git environment variables, AND/OR to include 
the what Git thinks the user's name name might be in the commit message 
template they're editing (like the file list).
