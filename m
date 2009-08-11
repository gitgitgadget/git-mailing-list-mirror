From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v2 4/4] read-tree: add --no-sparse to turn off sparse 
	hook
Date: Tue, 11 Aug 2009 14:08:59 +0700
Message-ID: <fcaeb9bf0908110008g1cbd3442p180557cbe6f24bb1@mail.gmail.com>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com> 
	<1249917562-5931-2-git-send-email-pclouds@gmail.com> <1249917562-5931-3-git-send-email-pclouds@gmail.com> 
	<1249917562-5931-4-git-send-email-pclouds@gmail.com> <1249917562-5931-5-git-send-email-pclouds@gmail.com> 
	<alpine.DEB.1.00.0908101842530.8324@intel-tinevez-2-302> <fcaeb9bf0908101838k37751fclac5c572eb042138e@mail.gmail.com> 
	<7vhbwforvk.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0908110846050.4638@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 11 23:02:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MayU9-0002HA-AQ
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 23:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbZHKVCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 17:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754515AbZHKVCA
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 17:02:00 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:36984 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbZHKVB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 17:01:58 -0400
Received: by yxe5 with SMTP id 5so5081078yxe.33
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8UHSzanIcf6+cWr/0sqfu+ntG9q0Y7avwjj0WNjpQl0=;
        b=Pk84bTOZe3GJ4COX10AHSe9mKyM0vwP+yTBcAEsGk1abJNL9IhrA53VTlLHQXOJI6W
         Pj47jA/QKtvIR4saaF64GkZ7KppUU4OfU3fgP/fuYacn5mJ+s2tjIncAXKoIBMosicYx
         zaduf49XtO/O263HHozKc5cjDr+nMQ1OzmX84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DDqo/j1t6pq6KSwPeN3qU+8IWUJ0RW69wycTDBZcVk9ox/4lirtvB96QsRQ5vkO9yV
         ZdpKvi5mbA5i2DXZ6JmR+qq7rTsCiMRZ/8kgbBoUy2bSNMdZNJ8I8R0WYzuVY9UAr//r
         l1YWaWerWXIwrfsj6JZtHCWdCBjd3L1wEp2xs=
Received: by 10.100.96.4 with SMTP id t4mr4762390anb.170.1249974559171; Tue, 
	11 Aug 2009 00:09:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908110846050.4638@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125598>

On Tue, Aug 11, 2009 at 1:50 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
>> Why not making the hook to be skipped by default, and pass an explicit
>> option to trigger the hook?
>>
>> I like Dscho's other suggestion to use patterns like .gitignore instead
>> of using hook scripts that needs to be ported across platforms, by the
>> way.
>
> I forgot to mention that I checked dir.c to verify that
> add_excludes_from_file_1() (which is static, so you'll either need to use
> it in the same file, or even better, export it renaming it to something
> like add_excludes_from_file_to_list()) and excluded_1() (same here)
> already do a large part of what you need.

Indeed (and I have that code too). I still like the hook though
because you have more freedom in defining your worktree (and yes, less
portable). I wanted to make something generic enough that you can
build higher "strategies" on top, like .gitignore-based patterns.
Anyway I'll send out another patch for .gitignore patterns tonight and
see how it goes.
-- 
Duy
