From: "Francis Moreau" <francis.moro@gmail.com>
Subject: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 16:00:28 +0200
Message-ID: <38b2ab8a0808110700x595448fco46d24a3e6582d024@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 16:01:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSXxl-0004hu-8m
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 16:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbYHKOAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 10:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbYHKOAa
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 10:00:30 -0400
Received: from hs-out-0708.google.com ([64.233.178.242]:32808 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbYHKOAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 10:00:30 -0400
Received: by hs-out-0708.google.com with SMTP id 4so145695hsl.5
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=tHeWGTFwDx1+vE3jyJXqSToL8w1jcrv2L9+Pfpue2nU=;
        b=EzD1186w4zOOfHX7lwv6xmhy2VApS64J8UWPvzExqtZ/MrMN5hAWfdXedtaRIeXjn6
         00EpKdwnBuincARTxaO8+qmiZ4A9m5bUOiBQHj5fjrijWRLRXw6U1XCt4Tl5L5YcL7h5
         CyXm9l6okhI/Q39Hf2h209t8MUNaPuZ23rToE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=v2T1nHxLLj7rLO/oPAu9hVOLFOliEEUVZRwLmJNh9nTj+5zZBAjiXNzDAs+WEbpZp7
         w243EJilFdf0cWlKrGAk+SThnCl0bmCphicRsQ/Dop/KIfshFM4AGJrBc68TZzATzl+/
         At8SYUwdXdrQ7T5RMeye+jUdK2KKZ5Hi0XKBo=
Received: by 10.90.53.5 with SMTP id b5mr1779164aga.21.1218463228375;
        Mon, 11 Aug 2008 07:00:28 -0700 (PDT)
Received: by 10.90.98.3 with HTTP; Mon, 11 Aug 2008 07:00:28 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91936>

Hello

I found this in git bisect:

              printf >&2 'Are you sure [Y/n]? '
              case "$(read yesno)" in [Nn]*) exit 1 ;; esac

which looks very weird since read(1) returns a status and not the
string reads from std input.

Am I missing something ?

Thanks
-- 
Francis
