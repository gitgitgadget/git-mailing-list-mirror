From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [RFC] git-submodule: multiple-level modules definition
Date: Mon, 3 Mar 2008 20:45:08 +0800
Message-ID: <46dff0320803030445o6f37e102heda4878c2d865347@mail.gmail.com>
References: <46dff0320803020911m30c8e3b3w80c0c92258a45f0f@mail.gmail.com>
	 <8c5c35580803021018v7590ad76kbbab2b1113e27666@mail.gmail.com>
	 <46dff0320803021747y6e334903pf8b5a77168bc7882@mail.gmail.com>
	 <8c5c35580803022257n7ff0cdc3i1e72a0034d254aa4@mail.gmail.com>
	 <46dff0320803030302t286c33a5h3555200c9e8840e3@mail.gmail.com>
	 <8c5c35580803030351l2e8d7eedq58108b54bf07dc5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 13:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWA3D-0005YY-93
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 13:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbYCCMpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 07:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbYCCMpN
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 07:45:13 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:3502 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbYCCMpM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 07:45:12 -0500
Received: by an-out-0708.google.com with SMTP id d31so1222084and.103
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 04:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Yud3PeaGmOtz4/upuaQj3AwerIvaCePRis5q5vXxg6M=;
        b=FlQdX1LcrLAunN5fa9OEqw7SfH/vJeKKaVnGXKwLDPBKZCo7JSVLVuN+xKwe2/Lk31KNg3ih/mjHRy51H0r0OZcvXAmqxw4x21TcsJ7ifcrNwSF12thBj5+sFhr8s8l+/rROCkhUvQVRrVmLCtAGyMdw+jNheaJnxrU0+8WP0JU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W6u60TPYfTcbKe8NPAs4bSVKjBdhzzFOg6mlpOSuz2r2PtkfO2FNmL3Qyj/yuSVMMTj3JMgCvY2cmvxOEE7/57SOVKZ3jqYxJUVAWN8/82vOl8yacGPHfjqE7JITw/E9rBAhdLK4LX1wODypig8b7+LSc+nk/EKSdSNJt8ON/4A=
Received: by 10.100.108.20 with SMTP id g20mr29570194anc.34.1204548308811;
        Mon, 03 Mar 2008 04:45:08 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Mon, 3 Mar 2008 04:45:08 -0800 (PST)
In-Reply-To: <8c5c35580803030351l2e8d7eedq58108b54bf07dc5c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75924>

On Mon, Mar 3, 2008 at 7:51 PM, Lars Hjemli <hjemli@gmail.com> wrote:
> On Mon, Mar 3, 2008 at 12:02 PM, Ping Yin <pkufranky@gmail.com> wrote:
>  >
>  > On Mon, Mar 3, 2008 at 2:57 PM, Lars Hjemli <hjemli@gmail.com> wrote:
>  >  > On Mon, Mar 3, 2008 at 2:47 AM, Ping Yin <pkufranky@gmail.com> wrote:
>  >  >  >  But why always
>  >  >  >  use git init even when we don't have the local configuration
>  >  >  >  requirement?
>  >  >
>  >  >  We need a way to tell git which of those submodules we are interested
>  >  >  in, i.e. which submodules to clone/fetch during 'git submodule
>  >  >  update'.
>  >  >
>  >  Now that's easy with the multiple level module definition. We can now
>  >  group our modules by hierachy and designate modules we are interested
>  >  by logical names such as crawler or search as my proposal has
>  >  mentioned.
>
>  Sorry, you've lost me here. How is 'git submodule update' going to
>  avoid cloning/fetching all submodules with your proposal?
>
>  PS: the supposed work-flow is an initial 'git submodule init foo bar
>  baz' (i.e. register the submodules you're interested in checking out)
>  followed by an occasional 'git submodule update' (i.e. update all the
>  submodules you are interested in).
>

See my first email. In following .gitmodules example, we can use "git
submodule update service" to update all sub-submodules of submodule
"service" (util, imsearch, imcrawler). We don't have to do "git init"
first.

Without the multiple level module definition, "git init" is good idea,
since every time we want to 'git update', we needn't give so many
module paths. However, if we introduce multiple level module
definition, we can define the module groups we are interested such as
crawler, search and the toppest group service. So we just need to type
one or few module names which makes "git init" not so useful.

And it's more flexible by using module name: at one time we can update
"cralwer" module group, and at another time we can update "search"
module group.


.gitmodules example
------------------------------------------------------
[submodule "service"]
   submodule = crawler
   submodule = search
[submodule "crawler"]
   submodule = util
   submodule = imcrawter
[submodule "search"]
   submodule = util
   submodule = imsearch
[submodule "util"]                      (1)
   url = git://xyzzy/util.git
[submodule "imsearch"]
   path = search/imsearch
   url = git://xyzzy/imsearch.git
[submodule "imcrawler"]
   path = crawler/imcrawter
   url = git://xyzzy/imcrawter.git
------------------------------------------------------
>  --
>  lh
>



-- 
Ping Yin
