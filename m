From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Wed, 14 Mar 2007 23:54:45 +0100
Message-ID: <81b0412b0703141554r524346d0kf73a5d43b49ed99a@mail.gmail.com>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
	 <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703141533q4e71e67aqaa83de45fa9e3988@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 23:54:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRcMs-00078N-CS
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 23:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbXCNWyr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 18:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbXCNWyr
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 18:54:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:58869 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbXCNWyr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 18:54:47 -0400
Received: by nf-out-0910.google.com with SMTP id o25so428546nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 15:54:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HeLtkZu6Zc4CzBc+K16sJ/4zIC+XNcTE8SI2U9uGNqWeQ0WbZ3J3VEfmhvaZsIKXhe5JqA4iMN7t9RZIM2NJVAztKqg+f4/KM4pAavpmzf/dT3jafoAxrRjFfnJGB5YapeXxkpsArCWvIojcFoUswfGI/4hkO3kNO/Q3xUpNunc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uh/OD7p0/skT+tfcFJgyRu1RRhGhVBZ9Y2kotz4ti1OPHI4qiaRWRpJKHIopNc7vrBP0AL3aiSCna9CkjyNYzeV78alqiC7iOSd3Lvxe1laBI/qCE6bv52czrsr/Bf9+PXqQQ9dANxt0WMwIDulQ+alGR+Avb0htnTEtyXwij0Q=
Received: by 10.78.123.4 with SMTP id v4mr1537412huc.1173912885742;
        Wed, 14 Mar 2007 15:54:45 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Wed, 14 Mar 2007 15:54:45 -0700 (PDT)
In-Reply-To: <81b0412b0703141533q4e71e67aqaa83de45fa9e3988@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42243>

On 3/14/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
> > The --quiet option is silently turned off (but --exit-code is
> > still in effect, so is silent output) if postprocessing filters
> > such as pickaxe and diff-filter are used.  For all practical
> > purposes I do not think of a reason to want to use these filters
> > and not viewing the diff output.
>
> pickaxe filter can be useful in hooks to enforce policy

Actually, I find it a bit strange to leave the output silent,
if --quiet is turned off. For all the user sees, it is still quiet
and exit-coded, just slow. Suggest either restore the
output format when turning the option off or not turning
it off at all (if possible. Is it?)
