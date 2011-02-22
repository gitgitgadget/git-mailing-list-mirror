From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: Re: How to create tags outside of refs/tags?
Date: Tue, 22 Feb 2011 07:17:20 +0100
Message-ID: <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 22 07:17:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrlYs-0001VK-BN
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 07:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915Ab1BVGRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 01:17:21 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51213 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab1BVGRV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 01:17:21 -0500
Received: by qyk7 with SMTP id 7so2600618qyk.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 22:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=Dips+nQpaMaSJrAZttbw05t4D0cudZbtFIb/AoNy9II=;
        b=BlCgOVR+bOnKEeWyFeScg5DTe4fGrUgFrhQL2JX9rjO5cGBecb6i7eC+F1ixQnfWG9
         rVMUxM+oZ47caeBSCBkeZ7yAvveQ7oAGKcS5kBFzR1UYr6Z6WftLaJX61mDyEvz+yXP1
         2nUhI5wsWsU8Q09cZVwZu5086ZtXzqY6N/kaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=EHK2G06rRNjdzv6PGyq8rlMiMFRzjwB+UkeM4YLjq5O0L193QWfxFeDluzyhYy7rEk
         O41VO5QW6gXP92mIvs+GfVb6w02FLktouUUrwYoy8enXhFUew22AbDlU/O8srydwL5Jg
         58cq9qv99cfoUf//cYqapiLDKSADCKSVDG++o=
Received: by 10.229.188.68 with SMTP id cz4mr1686058qcb.261.1298355440242;
 Mon, 21 Feb 2011 22:17:20 -0800 (PST)
Received: by 10.229.50.6 with HTTP; Mon, 21 Feb 2011 22:17:20 -0800 (PST)
In-Reply-To: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167527>

But look at my intention:

On Mon, Feb 21, 2011 at 18:21, Christian Halstrick
<christian.halstrick@gmail.com> wrote:
> I would like to create such tags to mark released states of my sources
> which should never be garbage collected in case no branch is pointing
> them anymore. On the other hand these tags should not pollute the
> namespace of normal tags, means: don't want a 'git tag' command to
> list those technical tags.

Is there any better way to achieve that certain commits are not
garbage collected than to create such tags. I love my foot and don't
want to "shoot if off" but I want to make sure the the
"release-process-machinery" in our company can be sure that certain
source states are never gc'ed. I can also live with creating normal
tags 'refs/tags/release/1.20' but would prefer a solution where 'git
tags' shows only developer created tags.

Will any ref underneath "refs/' prevent gc to garbage collect a
commit? Or only those in the well-known locations (e.g. refs/tags/*)
