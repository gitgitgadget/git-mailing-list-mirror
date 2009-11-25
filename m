From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] gitweb.js: Harden setting blamed commit info in incremental blame
Date: Wed, 25 Nov 2009 10:01:04 +0900
Message-ID: <20091125100104.6117@nanako3.lavabit.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <200911210132.44649.jnareb@gmail.com> <200911211556.52175.jnareb@gmail.com> <200911250145.16472.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 02:06:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND6LD-0006Sb-CB
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 02:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933784AbZKYBG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 20:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933753AbZKYBG0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 20:06:26 -0500
Received: from karen.lavabit.com ([72.249.41.33]:40380 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933742AbZKYBG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 20:06:26 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 89EB111B841;
	Tue, 24 Nov 2009 19:06:32 -0600 (CST)
Received: from 9867.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id BGM72P2HFX5E; Tue, 24 Nov 2009 19:06:32 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=FV6Gg7qtEvK+87bm4apQ0ahjYG9spBc0tZYX3MGNCMi/6TCTl1a4gaHJkxVcRtPOpcG40rNz8YDXLPEue04n//RQV3VajTCTdsgQzAb61R0TkdgZfTZanFFIYQhgUhkLupJlxru21ZQOdSbgvs5ZVKnenl+vKmVvHxB+vn/Ul9g=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <200911250145.16472.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133601>

Quoting Jakub Narebski <jnareb@gmail.com>

> On Sat, 21 Nov 2009, Jakub Narebski wrote:
>
> Below the same patch is in the form of a proper commit; although the title
> (subject) of this commit could be better...

Does this replace the first of the previous two-patch series? Is Stephen's second patch still needed (with his fix)?

Quoting Stephen Boyd <bebarino@gmail.com>

> Jakub Narebski wrote:
>> I have tested gitweb with both of your patches applied, serving gitweb
>> as CGI script using Apache 2.0.54 on Linux, and viewing from separate
>> computer on MS Windows XP, with the following results:
>>
>> * For the following browsers blame_incremental view on gitweb/gitweb.perl
>>   file produces correct output, but for progress info which instead of
>>   (  1%) -> ( 29%) -> (100%) looks more like ( 1%) -> (29%) -> (100%)
>
> This is due to an off-by-one error in the while loop. This should fix
> it. I'll probably squash this into patch 2 and resend.
>
> --->8----
>
> diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
> index 30597dd..9214497 100644
> --- a/gitweb/gitweb.js
> +++ b/gitweb/gitweb.js
> @@ -43,7 +43,7 @@ function padLeftStr(input, width, str) {
>        var prefix = '';
>
>        width -= input.toString().length;
> -       while (width > 1) {
> +       while (width > 0) {
>                prefix += str;
>                width--;
>        }

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
