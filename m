From: "Francis Moreau" <francis.moro@gmail.com>
Subject: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 15:57:04 +0200
Message-ID: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 15:58:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSXub-0003eD-OL
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 15:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbYHKN5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 09:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbYHKN5J
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 09:57:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:3856 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbYHKN5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 09:57:08 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2265450rvb.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=tHeWGTFwDx1+vE3jyJXqSToL8w1jcrv2L9+Pfpue2nU=;
        b=MpiSREAKp75UtO19m5D95yCS3VTVNK6OfyyQd0cY5iLnUcqFIVQNB5fx+/gStb7vg/
         KgPP+cTWQk2HsDpPHYrPspDwpGi5nNx5G7XUMA3OaYh9NGqHNwQRy+wsbs96jXrtUrn/
         eA/daJJcIL0NJPqDt3+enWw7jIk/npd1Mib4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=S/ZGO2ZJMpanlQ5D8wl2Pre6MWYuNzyDJUeqbs5xdTuI4iuM8z+PjQyk/W87ukhC19
         s6P87un29Tp/P3ILyqUJ1PV0e1XqJO54TThLIEuuGLoVeOttbbMUmD9Oln597/UFLv4B
         r6j54vyZ76ZwzXtlYeGc7A7Y+3/5Cc52X5+VE=
Received: by 10.140.202.12 with SMTP id z12mr3493345rvf.186.1218463027427;
        Mon, 11 Aug 2008 06:57:07 -0700 (PDT)
Received: by 10.140.170.16 with HTTP; Mon, 11 Aug 2008 06:57:04 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91935>

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
