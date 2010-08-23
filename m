From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] git-merge: ignore space support
Date: Mon, 23 Aug 2010 14:33:00 -0500
Message-ID: <20100823193300.GA2120@burratino>
References: <20100822054321.GA64856@ns1.cockos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
To: Justin Frankel <justin@cockos.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 21:34:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OncnE-00005j-5g
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 21:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab0HWTep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 15:34:45 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47852 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab0HWTeo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 15:34:44 -0400
Received: by vws3 with SMTP id 3so5526759vws.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 12:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=oq6iv+OpgrjDkWPjO/4MpKP8/7Fpvjwpje27ouNka4A=;
        b=qXntdbhp4zUnlBrfpUyMZeHyt2kyKUeI2kJTPW/RoeAnQEMqAz9t9ZETpuyCFF80IN
         x9NF2PP3qfdThXcHxdZypLpn0padDTUC3+vftB9tP50xKvTS9ACzGIGps1eo9ql+NhVN
         uYNRK5CvpWeidx0FVQcHGoobQ8y3g1jcLCAT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nV2nnR6P+a+UfsqyTTKtuaTdYq90Btz2YoOJtfUOJ9BhA4x9iunJY8xBm+cCIfHpjw
         Pj3s5FNhGAlaAxBL+QwCiyy3JU6+n2DPTEFTGJNdSybo6SsKRtsoBn2rQoWmFkUlbmWe
         R4uwkJ3/BTXPuEk3O0/rAoFsnWOwTAfPU2KuQ=
Received: by 10.220.158.9 with SMTP id d9mr3346360vcx.249.1282592082577;
        Mon, 23 Aug 2010 12:34:42 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id v11sm3685961vbb.11.2010.08.23.12.34.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 12:34:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100822054321.GA64856@ns1.cockos.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154246>

(+cc: Eyvind Bernhardsen, resident scholar on LF/CRLF conflicts)

Hi!

Justin Frankel wrote:

> I've added  support for merging with ignoring line endings (specifically 
> --ignore-space-at-eol) when using recursive merging.  I've added this as a 
> strategy-option, so that you can do:
> 
>    git merge --strategy-option=ignore-space-at-eol <branch>
> 
> and
> 
>    git rebase --strategy-option=ignore-space-at-eol <branch>
> 
> The only option I needed was ignore-space-at-eol, however it made some sense (to 
> me at least) to include the other xdiff options  (ignore-space-change, 
> ignore-all-space, patient).

Interesting.  The idea seems sane, provided it copes with edge cases
well (haven't checked the code yet).

I have even wished for a "merge -Xpatience" from time to time.

> Which branches should we derive from for things like this? The first patch is 
> for master, the second for next (there were enough changes in ll-merge that 
> the implementations are a bit different).

See Documentation/SubmittingPatches, section labelled "Decide what to
base your work on".

Generally the rule is to develop features against "master", or on top
of a relevant topic branch from "next" or "pu" if your implementation
requires features from it (or if it is likely to create heavy
conflicts).

If the patches seem sane, is it all right if we forge your sign-off?  (See
Documentation/SubmittingPatches for what this means.)

Since the threading does not seem to have worked correctly, here are
the patches, for reference.

for master: http://thread.gmane.org/gmane.comp.version-control.git/154166
for next: http://thread.gmane.org/gmane.comp.version-control.git/154167

Thanks,
Jonathan
