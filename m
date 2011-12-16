From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4.skipSubmitEdit
Date: Fri, 16 Dec 2011 19:50:30 +0000
Message-ID: <4EEBA106.9010001@diamand.org>
References: <1315514452.10046.0.camel@uncle-pecos> <4E6DB5F0.7080303@diamand.org> <1315847540.10046.29.camel@uncle-pecos> <20111018004500.GA31768@arf.padd.com> <4E9DBD0B.7020505@diamand.org> <20111020011610.GA7292@arf.padd.com> <CAFLRboo8DBk3zFEBF9OqKmre=d5PM7+3J9V0pHNz53MPtqjOWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, "L. A. Linden Levy" <alevy@mobitv.com>,
	git@vger.kernel.org
To: Michael Horowitz <michael.horowitz@ieee.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 20:57:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbdu9-000083-B2
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 20:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206Ab1LPT5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 14:57:09 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35992 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964909Ab1LPTzy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 14:55:54 -0500
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Dec 2011 14:55:54 EST
Received: by wibhm6 with SMTP id hm6so270344wib.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 11:55:52 -0800 (PST)
Received: by 10.180.102.74 with SMTP id fm10mr14523144wib.26.1324065033553;
        Fri, 16 Dec 2011 11:50:33 -0800 (PST)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id fk3sm15744114wbb.10.2011.12.16.11.50.31
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Dec 2011 11:50:32 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <CAFLRboo8DBk3zFEBF9OqKmre=d5PM7+3J9V0pHNz53MPtqjOWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187311>

On 16/12/11 15:38, Michael Horowitz wrote:
> All,
>
> It appears that this change has introduced a bug that causes submit to
> fail every time if you do not skip the submit edit.
>
>  From what I can tell, this is because the new edit_template method
> does not return True at the end.

Could you say exactly what you're doing?

I've just tried it myself and it seems to work fine:

git-p4 clone
git commit -m 'a change'
git-p4 submit
<quit from editor, with/without modifying it>

And I couldn't see any paths in edit_template that returned without a 
value of True, except the one where the user decides to bail out.

This is with Pete's skipSubmitEdit change.

Thanks!
Luke
