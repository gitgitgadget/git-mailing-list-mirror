From: liran ritkop <liran.ritkop@gmail.com>
Subject: git and touch screen
Date: Tue, 3 Aug 2010 06:06:30 -0700 (PDT)
Message-ID: <1280840790848-5368237.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 03 15:06:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgHCX-00066Q-C3
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 15:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809Ab0HCNGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 09:06:32 -0400
Received: from kuber.nabble.com ([216.139.236.158]:35882 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421Ab0HCNGb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 09:06:31 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <liran.ritkop@gmail.com>)
	id 1OgHCQ-00088N-Rb
	for git@vger.kernel.org; Tue, 03 Aug 2010 06:06:30 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152510>


Hi all
I am using linux davinci (33bd223c). my embedded card is da830 and i have a
touch screen on it - TS2046.
I found a driver on the net - (two files - TS2046.c TS2046.h ,  and some
changes to the config and makefile). I know that the board is connected to
the touch screen via spi. to be accurate - SPI1. Despite all of this, i dont
have in the /arch/arm/mach-davinci/board-da830-evm.c the structs that
include the spi and the touch screen. i saw in the internet something like
that, that i think that need to be added to this code source:

static struct spi_board_info da8xx_spi_board_info1[] = {
    [0] = {
        .modalias = "tsc2046_ts",
        .platform_data = &tsc2046IPWR_place_holder,
        .controller_data = &tsc2046IPWR_spi_cfg,
        .mode = SPI_MODE_0,
        .irq = 0,
        .max_speed_hz = 2 * 1000 * 1000  ,
        .bus_num = 1,
        .chip_select = 2,
    },
};


Altough, my guess is, that that code is from montavista, and i use git.
someone, please help..
-- 
View this message in context: http://git.661346.n2.nabble.com/git-and-touch-screen-tp5368237p5368237.html
Sent from the git mailing list archive at Nabble.com.
