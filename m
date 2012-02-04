From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [RFC/PATCH] verify-tag: check sig of all tags to given object
Date: Fri, 3 Feb 2012 21:56:56 -0800
Message-ID: <20120204055656.GC2477@tgrennan-laptop>
References: <7v8vkjl24d.fsf@alter.siamese.dyndns.org>
 <D140688E-B86C-4A67-9AD6-56160C26884D@ericsson.com>
 <20120204050818.GA2477@tgrennan-laptop>
 <7vsjirjhp7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jasampler@gmail.com, tom.grennan@ericsson.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 06:57:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtYcy-0007NK-I6
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 06:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab2BDF5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 00:57:03 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40426 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab2BDF5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 00:57:01 -0500
Received: by vbjk17 with SMTP id k17so3011649vbj.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 21:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=akcLSP7MWFpVxaZ0PmziogmdNZuWTLgXWuv8OpgD3SI=;
        b=lz8b9fq9l4gxjgNL5ukeY/rmToUfAvvJkGgk+pvcKb7LHQ1g+UGChDQLjn9iojcHii
         1oUhpUlA8khwPEa2vpanIW1F7SsCDDkuea4Oe1yRwhPwZ+tA6XqmZGe8s35iYnaJCyv/
         cjonJbL4aNNxWyhdTncq3iASn4Tk2WNx/6YTI=
Received: by 10.52.67.35 with SMTP id k3mr4700425vdt.38.1328335020895;
        Fri, 03 Feb 2012 21:57:00 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id ei6sm5256475vdc.6.2012.02.03.21.56.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 21:56:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vsjirjhp7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189846>

On Fri, Feb 03, 2012 at 09:22:44PM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>> Wouldn't you want Shawn and Jeff to tag the object (commit, tree, or
>> blob) that you had tagged?
>
>No.
>
>We _designed_ our tag objects so that they are capable of pointing at
>another tag, not the object that is pointed at that other tag.  And that
>is the example usage I gave you.
>
>The statement by Shawn and Jeff, "This tag is Gitster's" is exactly that.
>It was not about asserting the authenticity of the commit. It was about
>the tag object I created.

Hmm, how about "git verify-tag [[-v] [--to]] <tag|object>"?
With "--to", all tags to the given tag (or object) are verified.
Without "--to" just the given <tag> is verified.

>>    gitster$ git verify-tag --pointed v1.7.10
>>    tag v1.7.10: OK
>
>Just saying "$name: OK" will *never* be acceptable. "A signature made by
>any key in my keychain is fine" is not the usual use case. At least the
>output needs to be "Good signature from X".

OK, I'll have to play with the gpg --verify-options.

-- 
TomG
