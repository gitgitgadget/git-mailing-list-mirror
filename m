From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Create pack-write.c for common pack writing code
Date: Wed, 2 May 2007 10:25:07 -0700
Message-ID: <56b7f5510705021025j23e2ca3al7a72aeee33ff86aa@mail.gmail.com>
References: <46378656.9080109@gmail.com> <20070502161648.GK5942@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>, danahow@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 02 19:25:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjIaE-0005ok-0I
	for gcvg-git@gmane.org; Wed, 02 May 2007 19:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766519AbXEBRZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 13:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766531AbXEBRZL
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 13:25:11 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:8546 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766519AbXEBRZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 13:25:08 -0400
Received: by nz-out-0506.google.com with SMTP id o1so211089nzf
        for <git@vger.kernel.org>; Wed, 02 May 2007 10:25:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cPbiXRTZOOZNRZW4vGCEYeX+OfV7IjNJlfDaZaWI8MtOrkFGEWOqZ+LGGIdSbJ+fKIKbyMNZx80D/9ekZ0iEPn7Ly08/HBtN82u2PeiJSNGFZbQIgWXmIhfkOfbPVxmxdtJPCAjMfwemWnMH+krAZIWNyLlht/q5wfJEUB442XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nuDSuBvEhE5D+cJdSMTlhINSPkHgdWgbWLenpxsLQmlhr+zSHWsbf3zpRJCDNkCEQk8us8c0lqWsWzk63pJf34959XNjIEH+HXk0Yp6tixbLD3wMqyN1LMFhAZMmxBeFNjRVIs3bJrvFmsL/gppstxdP2WRzch3ooFwDb23200E=
Received: by 10.114.126.1 with SMTP id y1mr320052wac.1178126707614;
        Wed, 02 May 2007 10:25:07 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Wed, 2 May 2007 10:25:07 -0700 (PDT)
In-Reply-To: <20070502161648.GK5942@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46040>

On 5/2/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Dana How <danahow@gmail.com> wrote:
> > Include a generalized fixup_header_footer() in this new file.
> > Needed by git-repack --max-pack-size feature in a later patchset.
> Thanks.  I'm applying this to my fastimport.git tree, but I changed
> the name to fixup_pack_header_footer().  I'm also refactoring the
> same code out of index-pack, to call your version.
>
> I'll ask Junio to pull your patch, and my index-pack cleanup soon.
> As soon as I'm sure everything still passes the tests.  ;-)
Sounds good.  I didn't refactor index-pack.c since that wasn't
what we discussed; pulling out the close() as you or Nicolas later
write is the only thing needed to include it too.

At this point,  I guess there's not much left to comment on in the
--max-pack-size=N patchset?  Should I update it for your _pack
name change/moving out the close()?  I' feel like I've really
spammed the list with the versions of this patchset (5 so far).

Also, any reaction to the pack.compression/--compression=N patch?
It was the smallest code delta/most significant low-hanging fruit
I could identify for my day-job workflow's performance.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
