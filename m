From: Bryan Turner <bturner@atlassian.com>
Subject: Re: [PATCH] The images from picon and gravatar are always used over
 http://, and browsers give mixed contents warning when gitweb is served over https://.
Date: Tue, 29 Jan 2013 15:16:22 +1100
Message-ID: <CAGyf7-Gub7pFY+NpX0Cp4p9bUyzZHfp6qj+b5uNOEgHfhSJykw@mail.gmail.com>
References: <1359416492-8597-1-git-send-email-admin@andrej-andb.ru>
	<7vtxq0u1v3.fsf@alter.siamese.dyndns.org>
	<CAGyf7-GJkKDWdykq8iv90tU3TUR5ZKUf2bQc9sJokbq-RFYBYg@mail.gmail.com>
	<20130129041206.GA15442@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 05:16:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U02co-0007FJ-Gy
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 05:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804Ab3A2EQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 23:16:25 -0500
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:37711 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753431Ab3A2EQY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 23:16:24 -0500
Received: from mail-ob0-f199.google.com ([209.85.214.199]) (using TLSv1) by na3sys009aob111.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUQdNFyMbaEIcBsGvXL1dix63p/+UcpV/@postini.com; Mon, 28 Jan 2013 20:16:23 PST
Received: by mail-ob0-f199.google.com with SMTP id wd20so100882obb.2
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 20:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:x-received:in-reply-to:references:date
         :message-id:subject:from:to:content-type:x-gm-message-state;
        bh=eSnOYxwlyI7tMDI87/odOCUzjDMVBUg9XlHxfXgB03Q=;
        b=ngfoFuaDC2N19Em7iHoQ4PSnvKDrKpu7OcY5UdWNzu0aXCoIEYY15KPoshZtTaClYg
         ezfnD4BX6xtk/mT+BmUVO4FlRAv5w5BONbtJAI9PDDdN8WIifnO8NUAZGExMH1p2LlOc
         uZy/jAYPH6vzQg/5qyA5PaBXm7WZ6S2S11PZgc7DEzCaiy4NO0PnXGakVmZhzYXfPKoe
         MNjkrVtv3IhtbELp8tZmW0uqKOCJUES5d0mF+JT0sGJWTDx3NzRZ422/G/MmH7JbGHLS
         mwFrHQAUymckpZWouzA7f/XXZzcgE2vI3VPj4D/ekM9ey1g2CzwO1btE0g9EomVFLr+B
         hQIw==
X-Received: by 10.60.5.231 with SMTP id v7mr105268oev.62.1359432983046;
        Mon, 28 Jan 2013 20:16:23 -0800 (PST)
X-Received: by 10.60.5.231 with SMTP id v7mr105264oev.62.1359432982898; Mon,
 28 Jan 2013 20:16:22 -0800 (PST)
Received: by 10.182.232.101 with HTTP; Mon, 28 Jan 2013 20:16:22 -0800 (PST)
In-Reply-To: <20130129041206.GA15442@google.com>
X-Gm-Message-State: ALoCoQkKkyvnNCraRcTqFJXDUtgQjiCJtCVTDd0fiixPd7MZ7loBV8Ugw+bDg53clKTKCR0Z8g1SzSNEe42sbPbkVW0q81GB52+n/mppgqRjOHkWeRGPFq0GwqAa3SVrMTR925DZoYByRm0xOUqlYyI67V0lrLf5iQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214898>

Interesting. I wonder if they've changed it recently. I only pointed
it out because a software product I'm working on had a bug because it
was building the URLs with "https://www..." and the resulting images
were showing as X's instead of avatars. We had to change the
implementation to use "https://secure..." to get the avatars to load
correctly. That's been ~8 months ago now, though, so maybe it's no
longer the case. It seems like it would be much more convenient if
they just changed the scheme.

Bryan

On 29 January 2013 15:12, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Bryan,
>
> Bryan Turner wrote:
>
>> This won't work correctly as-is. The secure URL for Gravatar is
>> "https://secure.gravatar.com"[1], not "https://www.gravatar.com".
>
> Odd.  "https://www.gravatar.com/" also seems to work.  I've put in a
> technical support query to find out what the Gravatar admins prefer.
>
> Thanks,
> Jonathan
