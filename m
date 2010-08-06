From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git server eats all memory
Date: Fri, 6 Aug 2010 11:51:33 +1000
Message-ID: <AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	<87ocdhlgbl.fsf@kanis.fr>
	<AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git <git@vger.kernel.org>
To: Ivan Kanis <expire-by-2010-08-10@kanis.fr>
X-From: git-owner@vger.kernel.org Fri Aug 06 03:51:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhC61-0002gw-4O
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 03:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935187Ab0HFBvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 21:51:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46374 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935182Ab0HFBve (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 21:51:34 -0400
Received: by wwj40 with SMTP id 40so8519078wwj.1
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 18:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=kULAgJevfk7hgX6mL+/VwlLj9i24LaifBsXTSM0yZsU=;
        b=eHEkxVJ84IpCXpFEfD0QEyatlr49arMN3qz7VN9MpW1R9OGJ0mHvq4sVWCZ+Z0Ku+4
         kaX+YMnydQ8XFjMTVVhmlrvc4wRxcIvxnyDkfXK0mlonarh6iBH15BE5tbFqoYcgUE0G
         PbIoYzmkcj6DZ8eZm9y8WSz7vo8d7upCbeJX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xoGmDikW9oI1R4+JhPz+5DPSEHoZxN8I6epdYpDrLOSRqZLnUF9Shonr1jy98l4o24
         kK3OoMO5l3jnkwzAnMJtPDS7opoGLwdPKqxy5MlyvMZ41CLujLlvNTAekLP21SqUuvvR
         3yLXouKbLJ6H6VwmfYs2SoRCX9up9rONZNWxU=
Received: by 10.216.44.209 with SMTP id n59mr295521web.58.1281059493549; Thu, 
	05 Aug 2010 18:51:33 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Thu, 5 Aug 2010 18:51:33 -0700 (PDT)
In-Reply-To: <AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152743>

On Fri, Aug 6, 2010 at 11:37 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Thu, Aug 5, 2010 at 4:33 PM, Ivan Kanis
> <expire-by-2010-08-10@kanis.fr> wrote:
>> I am ready to do whatever to diagnose the problem. I know C pretty well
>> and am ready to look into it but I am not sure where to start.
>
> Try "git pack-objects --all --stdout > /dev/null" on the repo on
> server to see if it uses the same amount of memory you saw in cloning.
> You can then try debugging that command if it does.

Naah, git pack-objects needs list of commit tips. Try
git for-each-ref|cut -c 1-40|git pack-objects --all --stdout > /dev/null
-- 
Duy
