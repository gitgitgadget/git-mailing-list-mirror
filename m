From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH] Documentation: indent-with-non-tab uses tabwidth setting,
 not just 8
Date: Sun, 16 Sep 2012 23:41:58 -0600
Message-ID: <5056B826.4030106@icecavern.net>
References: <1347815548-19305-1-git-send-email-wjl@icecavern.net> <7v392hxm94.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:44:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDU85-0002J5-Il
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 07:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab2IQFoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 01:44:09 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:39689 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751225Ab2IQFoH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 01:44:07 -0400
Received: from [10.0.0.14] (c-76-113-27-84.hsd1.nm.comcast.net [76.113.27.84])
	by icecavern.net (Postfix) with ESMTPSA id F05C835CF1;
	Sun, 16 Sep 2012 23:44:02 -0600 (MDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120418 Icedove/11.0
In-Reply-To: <7v392hxm94.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205649>

On 09/16/2012 11:16 PM, Junio C Hamano wrote:
> I would rather see this part left untouched.
> 
> Your new text will force people who are not interested in using
> non-standard tab width to read through the bulletted list, only to
> find "The default tab width is 8".  I think that is a regression in
> the documentation for more common readers.
> 
> When somebody wants to use `indent-with-non-tab` and gets offended
> by the seemingly hardcoded "8" in the description, the reader has
> incentive to find out if there is a way to change that 8, and will
> find `tabwidth=<n>` in the same bulletted list described, with the
> effect it has on both `indent-with-non-tab` and `tab-in-indent`.
> 
> I think that should be sufficient for people who do use non-standard
> tab width using tabwidth=<n>.

Well, I'm not going to push the issue further than this e-mail, but I
very much disagree. Please think about this:

  * The whole whitespace section talks generically about "spaces" and
"tab characters". All of the options talk about tab in a generic way,
with the one single exception of "indent-with-non-tab".

  * I know all about the tabwidth setting (I have it set in my
configuration), but when I went looking in the whitespace documentation
to try to flag a certain error I wanted to avoid, I was confused because
"indent-with-non-tab" didn't do what I wanted ... instead it apparently
used a hard-coded length of 8 spaces. My first thought was, well, I'd
better fix THAT bug!

  * Of course, I did an experiment, and of course, it DOESN'T ACTUALLY
DO WHAT THE DOCUMENTATION SAYS, instead it uses the tabwidth. This is
good, I'm not complaining about how it works: this *is* what I want it
to do. But the documentation is still wrong.

  * So, as you say, "the reader has incentive to find out if there is a
way to change that 8". I did get incentive to find that, but it took me
a few minutes of wasted time experimenting around with it, and then
motived me to write a patch so that no one else will ever get confused
about it again.

If I've perhaps convinced you that it would be beneficial to make the
documentation for this option precisely correct, but you don't like how
it's worded (it's the way it is because I tried to make a very minimal
change) I'd be happy to revise the patch, perhaps by changing the order
of presentation of the options (e.g. mentioning tab width earlier in the
section, or in some other way that you or someone may want to suggest).

In any case, please, let's find some way to make the documentation both
easy to read and also absolutely correct! =)
